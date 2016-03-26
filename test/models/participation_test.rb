# == Schema Information
#
# Table name: participations
#
#  id            :integer          not null, primary key
#  status        :integer          not null
#  winners_count :integer          default("0"), not null
#  user_id       :integer          not null
#  battle_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
