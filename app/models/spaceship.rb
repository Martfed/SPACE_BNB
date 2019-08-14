class Spaceship < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, :address, :city, :country, :country, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true }

  mount_uploader :image, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
