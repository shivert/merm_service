class Category < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :merms
  belongs_to :user, foreign_key: "owner_id"

  DEFAULT_CATEGORIES = ["Recent", "Favorites", "Unread Resources"]

  validates_uniqueness_of :name, scope: :owner_id
  validates :merms, length: { minimum: 0, maximum: 0 }, if: :default_category?

  scope :custom, -> { where.not(name: DEFAULT_CATEGORIES ) }

  after_update { self.merms.each(&:touch) }

  def default_category?
    DEFAULT_CATEGORIES.include?(name)
  end

  def self.sync(owner_id, categories)
    ## First, find All Categories Belonging to the user
    old_categories = Category.where(owner_id: owner_id)

    old_categories.each do |old_category|
      match = categories.index { |new_category| new_category["id"] == old_category.id }

      ## Check to see if we can find a match with new category
      if match.present?
        ## If custom, allow for update of both name and rank
        ## If not custom, only allow for update of rank
        if old_category.custom &&
            (old_category.name != categories[match]["name"] ||
                old_category.rank != match)

          Category.update(old_category.id, :name => categories[match]["name"], :rank => match)
        elsif !old_category.custom && old_category.rank != match
          Category.update(old_category.id, :rank => match)
        end
      else
        Category.destroy(old_category.id)
      end
    end

    ## Find all new categories without ID, and create them
    categories.each_with_index do |category, idx|
      if category["id"].nil?
        Category.create!(
            name: category["name"],
            rank: idx,
            owner_id: owner_id,
            custom: true
        )
      end
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
        only: [:id, :name, :rank, :owner_id, :custom]
    )
  end

end

# Delete the previous articles index in Elasticsearch
Category.__elasticsearch__.client.indices.delete index: Category.index_name rescue nil

# Create the new index with the new mapping
Category.__elasticsearch__.client.indices.create \
  index: Category.index_name,
  body: { settings: Category.settings.to_hash, mappings: Category.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Category.import

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  custom     :boolean          default(TRUE), not null
#  name       :string           not null
#  rank       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer          not null
#
