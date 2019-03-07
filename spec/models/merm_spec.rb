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

require 'rails_helper'

RSpec.describe Merm, elasticsearch: true, :type => :model do
  it 'should be indexed' do
    expect(Merm.__elasticsearch__.index_exists?).to be_truthy
  end
end
