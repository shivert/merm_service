class Tag < ApplicationRecord
  has_one :merm
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  merm_id    :integer
#
