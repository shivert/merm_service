# == Schema Information
#
# Table name: merms
#
#  id            :integer          not null, primary key
#  archived      :boolean          default(FALSE), not null
#  captured_text :string
#  content_type  :string
#  deleted_at    :datetime
#  description   :string
#  expired       :boolean          default(FALSE), not null
#  expiry_date   :datetime
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
# Indexes
#
#  index_merms_on_deleted_at  (deleted_at)
#

require 'rails_helper'

RSpec.describe Merm, elasticsearch: true, :type => :model do
  it 'should be indexed' do
    expect(Merm.__elasticsearch__.index_exists?).to be_truthy
  end
end
