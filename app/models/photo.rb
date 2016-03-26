# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  file       :string
#  status     :integer          not null
#  user_id    :integer          not null
#  round_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :round

  before_validation :set_defaults, on: :create

  enum status: {
    in_progress: 0,
    win: 1,
    lose: 2
  }

  mount_uploader :file, PhotoUploader

  validates :user,
    presence: true,
    uniqueness: {scope: :round_id}
  validates :round, presence: true
  validates :file, presence: true

  def winner!
    transaction do
      win!
      update_participation_counter_cache!
    end
  end

  def find_image_colors
    # TODO определение победителя
  end

  private

    def update_participation_counter_cache!
      part = round.battle.participations.where(user_id: user_id).first
      part.update_winners_counter!
    end

    def set_defaults
      self.status ||= :in_progress
    end
end
