class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :spaceship
  has_many :reviews, dependent: :destroy

  validates :start_date, :end_date, presence: true
  validates :confirmation_status, inclusion: { in: %w(pending accepted rejected active done) }
end
