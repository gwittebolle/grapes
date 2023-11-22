class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wines, dependent: :destroy
  has_many :bookings
  has_one_attached :avatar

  # Geocoding
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Validations
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
            file_content_type: { allow: ['image/jpeg','image/jpg', 'image/png', 'image/gif'] }
end
