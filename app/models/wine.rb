class Wine < ApplicationRecord
  belongs_to :user

  has_many :bookings
  validates :name, presence: true
  validates :price, presence: true
  has_one_attached :photo

end
