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

  def update_winners_counter!
    count = battle.photos.win.where(user_id: user_id).count
    update! winners_count: count
  end

  private

    def set_defaults
      self.status ||= :in_progress
      self.winners_count ||= 0
    end
end
