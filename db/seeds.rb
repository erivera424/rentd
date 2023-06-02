# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

puts "Cleaning database.."
Booking.destroy_all
Item.destroy_all
User.destroy_all

puts "Creating items..."
# Create 10 items with a Faker-generated user

user = User.new(
  email: "test@gmail.com",
  password: "123456"
)
user.save!

elizabeth = User.new(
  email: "elizabeth@gmail.com",
  password: "123456"
)
elizabeth.save!

shnai = User.new(
  email: "shnai@gmail.com",
  password: "123456"
)
shnai.save!

adinda = User.new(
  email: "adinda@gmail.com",
  password: "123456"
)
adinda.save!

bettina = User.new(
  email: "bettina@gmail.com",
  password: "123456"
)
bettina.save!

categories = ['dresses', 'tops', 'bottoms']

categories.each do |category|
  8.times do |num|
    item = Item.new(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence,
      brand: Faker::FunnyName.name,
      size: Faker::Number,
      original_price: Faker::Commerce.price(range: 100.0..500.0),
      price: Faker::Commerce.price(range: 10.0..100.0),
      user: [bettina, adinda, shnai, elizabeth].sample
    )

    file = File.open(Rails.root.join("app/assets/images/#{category}#{num + 1}.png"))
    item.photos.attach(io: file, filename: 'image.png', content_type: 'image/png')

    # Assign categories manually
    item.category = category

    fabric_details = ['Cotton', 'Linen', 'Satin', 'Wool', 'Silk']
    item.fabric_details = fabric_details.sample

    item.save!
    puts "#{item.title} created"
  end
end
