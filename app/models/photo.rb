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

  private

    def set_defaults
      self.status ||= :in_progress
    end
end
