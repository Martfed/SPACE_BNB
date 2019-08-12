class Spaceship < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, :address, :city, :country, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true }
end
