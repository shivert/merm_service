class Comment < ApplicationRecord

  belongs_to :user, foreign_key: "author_id"
  belongs_to :merm
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  merm_id    :integer
#
