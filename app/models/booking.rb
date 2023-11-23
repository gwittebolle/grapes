class Booking < ApplicationRecord
  belongs_to :wine
  belongs_to :user

  enum status: {
    created: 0,
    accepted: 1,
    rejected: 2,
    delivered: 3,
  }, _default: :created


end
