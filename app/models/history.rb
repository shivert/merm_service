class History < ApplicationRecord

  belongs_to :merm, touch: true
end

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
