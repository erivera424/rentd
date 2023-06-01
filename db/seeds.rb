# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Create 10 items with a Faker-generated user
10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save!

  item = Item.new(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    brand: Faker::FunnyName.name,
    size: Faker::Number,
    original_price: Faker::Commerce.price(range: 100.0..500.0),
    price: Faker::Commerce.price(range: 10.0..100.0),
    user: user
  )

  file = File.open(Rails.root.join("app/assets/images/bottoms1.png"))
  item.photos.attach(io: file, filename: 'image.png', content_type: 'image/png')

  # Assign categories manually
  categories = ['dresses', 'tops', 'bottoms']
  item.category = categories.sample

  fabric_details = ['Cotton', 'Linen', 'Satin', 'Wool', 'Silk']
  item.fabric_details = fabric_details.sample

  item.save!
end
