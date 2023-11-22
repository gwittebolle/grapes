class Wine < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :domain, presence: true
  validates :region, presence: true
  validates :year, presence: true
  validates :alcohol_level, presence: true
  validates :category, presence: true



end
