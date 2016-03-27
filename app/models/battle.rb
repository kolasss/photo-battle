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
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many :rounds, dependent: :destroy
  has_many :targets, through: :rounds
  has_many :photos, through: :rounds

  before_validation :set_defaults, on: :create

  enum status: {
    waiting_for_players: 0,
    in_progress: 1,
    finished: 2
  }

  def Battle.find_or_create user
    battle = Battle.find_waiting_for_players user
    battle ||= Battle.create_for_player user
    return battle
  end

  def start!
    transaction do
      in_progress!
      create_new_round!
    end
  end

  def create_new_round!
    # TODO сделать чтобы таргеты не повторялись
    offset = rand(Target.count)
    target = Target.offset(offset).first
    rounds.create! target: target
  end

  def round_ended!
    # TODO сделать проверку на создание нового раунда или завершение битвы
    set_winner!
  end

  private

    def Battle.find_waiting_for_players user
      battle = Battle
        .waiting_for_players
        .joins(:participations)
        .merge(Participation.where.not user_id: user.id)
        .first
      if battle.present?
        # TODO сделать проверку на количество участников в битве
        transaction do
          battle.participations.create!(user: user)
          battle.start!
        end
      end
      return battle
    end

    def Battle.create_for_player user
      transaction do
        battle = Battle.create!
        battle.participations.create!(user: user)
        return battle
      end
    end

    def set_defaults
      self.status ||= :waiting_for_players
    end

    def set_winner!
      transaction do
        winner_part = participations.order(winners_count: :desc).first
        winner_part.win!

        losers = participations.where.not(id: winner_part.id)
        losers.each(&:lose!)
        finished!
      end
    end
end
