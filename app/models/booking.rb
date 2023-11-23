class Booking < ApplicationRecord
  belongs_to :wine
  belongs_to :user

  enum status: {
    created: 0,
    accepted: 2,
    rejected: 3,
    delivered: 4,
  }, _default: :created


end
