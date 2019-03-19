class Share < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  belongs_to :merm, touch: true
  belongs_to :sharer, class_name: "User", foreign_key: "sharer_id"
  belongs_to :shared_with, class_name: "User", foreign_key: "shared_with_id"

  validates_uniqueness_of :merm_id, :scope => [:sharer_id, :shared_with_id]

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :created_at, type: "date"
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
        only: [:id, :read, :merm_id, :shared_with_id, :created_at],
        include: {
            sharer: {
                methods: [:fullname],
                only: [:fullname]
            },
            merm: {
                methods: [:get_tags],
                only: [:id, :name, :content_type, :resource_url, :get_tags]
            }
        }
    )
  end

  def set_viewed
    self.update(read: true)
  end

end

# Delete the previous articles index in Elasticsearch
Share.__elasticsearch__.client.indices.delete index: Share.index_name rescue nil

# Create the new index with the new mapping
Share.__elasticsearch__.client.indices.create \
  index: Share.index_name,
  body: { settings: Share.settings.to_hash, mappings: Share.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Share.import


# == Schema Information
#
# Table name: shares
#
#  id             :integer          not null, primary key
#  read           :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  merm_id        :integer
#  shared_with_id :integer
#  sharer_id      :integer
#
