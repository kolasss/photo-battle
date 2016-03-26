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

require 'test_helper'

class TargetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
