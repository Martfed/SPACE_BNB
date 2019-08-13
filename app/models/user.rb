class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :spaceships, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy

  validates :first_name, :last_name, :email, :species, presence: true
  validates :email, uniqueness: true
  validates :species, inclusion: { in: %w(Wookie Human Martian Mandalorian Droid Vulcan Borg Jedi Zetan Calaron) }
end
