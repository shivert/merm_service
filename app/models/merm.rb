require 'elasticsearch/model'
require 'uri'

class Merm < ApplicationRecord
  acts_as_paranoid

  include Elasticsearch::Model

  belongs_to :user, foreign_key: "owner_id"
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  belongs_to :category, foreign_key: "category_id", optional: true

  validates :content_type, :inclusion => { :in => CONTENT_TYPES }
  validates :resource_url, uniqueness: { scope: :owner_id }

  before_validation :set_content_type, on: :create
  before_validation :set_access_date, on: :create

  after_create_commit	:create_index
  after_update_commit	:update_index

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :content_type, analyzer: 'keyword'
    end
  end

  def create_index
    __elasticsearch__.index_document
  end

  def update_index
    if self.deleted_at.present?
      __elasticsearch__.delete_document
    else
      __elasticsearch__.update_document
    end
  end

  def self.find_authorized(id, user)
    Merm.find_by(id: id, owner_id: user.id)
  end

  def set_content_type
    uri = URI.parse(self.resource_url)
    type = CONTENT_TYPE_MAPPING[uri.host.to_sym] || "chrome"

    self.content_type = type
  end

  def set_access_date
    self.last_accessed = Time.now
  end

  def as_indexed_json(options = {})
    self.as_json(
        only: [:id, :name, :source, :content_type, :description, :owner_id, :category_id, :last_accessed, :resource_url, :favorite, :expired],
        methods: [:tags],
        include: {
            user: {
                methods: [:fullname],
                only: [:id, :fullname]
            },
            tags: {
                only: [:name]
            }
        }
    )
  end

  def share(sharer_id, users)
    shares = Share.where(:merm_id => self.id).pluck(:id, :shared_with_id)

    shares.each do |id, shared_with_id|
      ## Remove a Share
      if !users.include?(shared_with_id)
        Share.destroy(id)
      end
    end

    users.each do |user_id|
      Share.find_or_create_by(
               merm_id: self.id,
               sharer_id: sharer_id,
               shared_with_id: user_id
      )
    end
  end

  def get_tags
    self.tags.pluck(:name)
  end
end

# Delete the previous articles index in Elasticsearch
Merm.__elasticsearch__.client.indices.delete index: Merm.index_name rescue nil

# Create the new index with the new mapping
Merm.__elasticsearch__.client.indices.create \
  index: Merm.index_name,
  body: { settings: Merm.settings.to_hash, mappings: Merm.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Merm.import

# == Schema Information
#
# Table name: merms
#
#  id            :integer          not null, primary key
#  archived      :boolean          default(FALSE), not null
#  captured_text :string
#  content_type  :string
#  deleted_at    :datetime
#  description   :string
#  expired       :boolean          default(FALSE), not null
#  expiry_date   :datetime
#  favorite      :boolean          default(FALSE), not null
#  last_accessed :datetime
#  name          :string
#  resource_name :string
#  resource_url  :string
#  source        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  owner_id      :integer
#
# Indexes
#
#  index_merms_on_deleted_at  (deleted_at)
#
