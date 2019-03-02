require 'elasticsearch/model'

class ActiveRecord::Base
  cattr_accessor :skip_elasticsearch_callbacks
end

ActiveRecord::Base.skip_elasticsearch_callbacks = true

class Merm < ApplicationRecord
  belongs_to :user, foreign_key: "owner_id"
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless skip_elasticsearch_callbacks
  
  def self.find_authorized(id, user)
    Merm.find_by(id: id, owner_id: user.id)
  end

  def self.search(search, user)
    wildcard_search = "%#{search}%"

    where("owner_id IS :owner_id AND name LIKE :search OR description LIKE :search", search: wildcard_search, owner_id: user.id)
  end

  def as_indexed_json(options = {})
    self.as_json(
        only: [:id, :name, :owner_id],
        include: {
            user: {
                only: [:first_name, :last_name]
            },
            tags: {
                only: [:id, :name]
            }
        }
    )
  end
end

# == Schema Information
#
# Table name: merms
#
#  id            :integer          not null, primary key
#  captured_text :string
#  description   :string
#  favorite      :boolean          default(FALSE), not null
#  last_accessed :datetime
#  name          :string
#  resource_name :string
#  resource_url  :string
#  source        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_id      :integer
#
