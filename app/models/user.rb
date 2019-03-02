class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :merms, :foreign_key => "owner_id", dependent: :destroy
  has_many :comments, :foreign_key => "author_id", dependent: :destroy
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
#  last_sign_in_at                 :datetim
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
