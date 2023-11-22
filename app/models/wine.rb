class Wine < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true
  validates :domain, presence: true
  validates :region, presence: true
  validates :year, presence: true
  validates :alcohol_level, presence: true
  validates :category, presence: true



end
