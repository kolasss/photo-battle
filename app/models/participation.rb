# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  status     :integer          not null
#  user_id    :integer          not null
#  battle_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :battle

  before_validation :set_defaults, on: :create

  enum status: {
    in_progress: 0,
    win: 1,
    lose: 2
  }

  validates :user,
    presence: true,
    uniqueness: {scope: :battle_id}
  validates :battle, presence: true

  private

    def set_defaults
      self.status ||= :in_progress
    end
end
