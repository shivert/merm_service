require 'rails_helper'

RSpec.describe Merm, elasticsearch: true, :type => :model do
  it 'should be indexed' do
    expect(Merm.__elasticsearch__.index_exists?).to be_truthy
  end
end