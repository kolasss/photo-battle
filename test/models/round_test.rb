# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  number     :integer          not null
#  battle_id  :integer          not null
#  target_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
