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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # spec "the truth" do
  #   assert true
  # end
end
