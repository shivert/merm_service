# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  visit_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  merm_id    :integer
#

require 'rails_helper'

RSpec.describe History, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
