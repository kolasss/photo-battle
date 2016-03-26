# == Schema Information
#
# Table name: battles
#
#  id         :integer          not null, primary key
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Battle < ActiveRecord::Base
  has_many :participations
  has_many :rounds
  has_many :users, through: :participations

  before_validation :set_defaults, on: :create

  enum status: {
    waiting_for_players: 0,
    in_progress: 1,
    finished: 2
  }

  private

    def set_defaults
      self.status ||= :waiting_for_players
    end
end
