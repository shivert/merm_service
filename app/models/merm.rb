require 'elasticsearch/model'
require 'uri'

class Merm < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless skip_elasticsearch_callbacks

  before_validation :set_content_type, on: :create
  before_validation :set_access_date, on: :create

  belongs_to :user, foreign_key: "owner_id"
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category, foreign_key: "category_id", touch: true

  validates :content_type, :inclusion => { :in => CONTENT_TYPES }

  after_save :reindex

  def reindex
    __elasticsearch__.index_document
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
        only: [:id, :name, :source, :content_type, :description, :owner_id, :category_id, :last_accessed],
        include: {
            user: {
                only: [:first_name, :last_name]
            },
            tags: {
                only: [:id, :name]
            },
            category: {
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
#  content_type  :string
#  description   :string
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
