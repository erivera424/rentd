class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :images

  CATEGORIES = ['dresses', 'tops', 'bottoms']

  validates :title, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES }
  has_many_attached :photos

  include PgSearch::Model
  # :search_by_title_and_description_and_size_and_brand_and_category,
  pg_search_scope :search_by_five_columns,
    against: [ :title, :description, :size, :brand, :category ],
    using: {
      tsearch: { prefix: true }
    }

end
