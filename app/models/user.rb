class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  after_create_commit :init_user_categories

  has_many :merms, :foreign_key => "owner_id", dependent: :destroy
  has_many :comments, :foreign_key => "author_id", dependent: :destroy
  has_many :categories, -> { custom }, :foreign_key => "owner_id", dependent: :destroy

  def init_user_categories
    fixed_categories = ["Recent", "Favorites", "Unread Resources"]

    3.times do |idx|
      Category.create!(
          owner_id: self.id,
          name: fixed_categories[idx],
          rank: idx,
          custom: false
      )
    end
  end
  
  def shared_with_merms
    Share.where(:shared_with_id => self.id).map(&:merm)
  end

  def fullname
    "#{first_name} #{last_name}"
  end

end

# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  current_sign_in_at              :datetime
#  current_sign_in_ip              :string
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  first_name                      :string           not null
#  last_name                       :string           not null
#  last_sign_in_at                 :datetime
#  last_sign_in_ip                 :string
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  sign_in_count                   :integer          default(0), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
