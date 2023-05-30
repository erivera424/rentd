class Item < ApplicationRecord
  belongs_to :users
  has_many :bookings
  validates :title, uniqueness: true
end
