class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings

  CATEGORIES = ['dresses', 'tops', 'bottoms']

  validates :title, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES }
end
