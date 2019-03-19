class Tag < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :merm, touch: true
  belongs_to :user, foreign_key: "owner_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:merm_id, :owner_id]

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :name, analyzer: 'keyword'
    end
  end

end

# Delete the previous articles index in Elasticsearch
Tag.__elasticsearch__.client.indices.delete index: Tag.index_name rescue nil

# Create the new index with the new mapping
Tag.__elasticsearch__.client.indices.create \
  index: Tag.index_name,
  body: { settings: Tag.settings.to_hash, mappings: Tag.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Tag.import


# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  merm_id    :integer
#  owner_id   :integer
#
# Indexes
#
#  index_tags_on_owner_id  (owner_id)
#
