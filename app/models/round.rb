# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  number     :integer          not null
#  status     :integer          not null
#  battle_id  :integer          not null
#  target_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Round < ActiveRecord::Base
  belongs_to :battle
  belongs_to :target
  has_many :photos, dependent: :destroy

  before_validation :set_number, on: :create
  before_validation :set_defaults, on: :create

  enum status: {
    in_progress: 0,
    finished: 1
  }

  # validates :battle,
  #   presence: true,
  #   uniqueness: {scope: :target_id}
  validates :target, presence: true
  validates :number,
    presence: true,
    uniqueness: {scope: :battle_id}

  def find_winner
    # TODO сделать норм, пока костыли
    if photos.length > 1
      transaction do
        color = target.criterion["color"]

        results = []

        # определяем рейтинг фоток
        photos.each do |photo|
          photo.find_color_share(color)
        end

        # находим победителя по рейтингу
        winner_photo = photos.order(rating: :desc).first
        loser_photo = photos.where.not id: winner_photo.id
        loser_photo.each(&:lose!)
        winner_photo.winner!

        finished!
        battle.round_ended!
      end
    end
  end

  private

    def set_number
      self.number = battle.rounds.length + 1
    end

    def set_defaults
      self.status ||= :in_progress
    end
end
