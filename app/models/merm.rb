class Merm < ApplicationRecord

  belongs_to :user, foreign_key: "owner_id"
  has_many :tags, dependent: :destroy
  
  def self.find_authorized(id, user)
    Merm.find_by(id: id, owner_id: user.id)
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
