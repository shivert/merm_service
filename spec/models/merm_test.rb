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

require 'test_helper'

class MermTest < ActiveSupport::TestCase
  # spec "the truth" do
  #   assert true
  # end
end
