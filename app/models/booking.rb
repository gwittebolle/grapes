class Booking < ApplicationRecord
  belongs_to :wine
  belongs_to :user
end
