class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :title, uniqueness: true
  has_many_attached :photos
end
