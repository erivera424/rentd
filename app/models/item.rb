class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :title, uniqueness: true

  # # Add the name attribute
  # def name
  #   title
  # end
end
