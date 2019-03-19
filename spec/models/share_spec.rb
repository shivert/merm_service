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

require 'rails_helper'

RSpec.describe Share, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
