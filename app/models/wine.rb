class Wine < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  include Reusable

  REGION = ['Alsace', 'Bordeaux', 'Bourgogne', 'Champagne', 'Corse', 'Midi', 'Provence', 'Sud-ouest', 'Vallée de la Loire', 'Vallée du Rhône', 'Autre']

  validates :name, presence: true
  validates :region, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :year, presence: true
  validates :stock_quantity, presence: true
  validates :category, presence: true
  validates :region, inclusion: { in: REGION }
  validates :category, inclusion: { in: %w[Blanc Rouge Rosé Autre] }


end
