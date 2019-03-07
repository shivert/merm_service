class Category < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless skip_elasticsearch_callbacks

  has_many :merms
  belongs_to :user, foreign_key: "owner_id"

  after_update { self.merms.each(&:touch) }

  def self.sync(owner_id, categories)
    ## First, find All Categories Belonging to the user
    old_categories = Category.where(owner_id: owner_id)

    old_categories.each do |old_category|
      match = categories.index { |new_category| new_category["id"].to_i == old_category.id }

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
        Category.delete(old_category.id)
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

end

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
