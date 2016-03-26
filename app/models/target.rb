# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  desc       :text             not null
#  criterion  :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Target < ActiveRecord::Base
  has_many :rounds

  validates :desc, presence: true
  validates :criterion, presence: true
end
