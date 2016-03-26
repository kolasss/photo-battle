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

class Round < ActiveRecord::Base
  belongs_to :battle
  belongs_to :target
  has_many :photos

  before_validation :set_number, on: :create

  private

    def set_number
      self.number = battle.rounds.length + 1
    end
end
