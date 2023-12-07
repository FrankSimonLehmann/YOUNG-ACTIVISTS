# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"
require "faker"

puts "destroying previous seeds :wastebasket: GET REKT"
User.destroy_all
Demonstration.destroy_all
Topic.destroy_all
Type.destroy_all
DemoType.destroy_all
Bookmark.destroy_all
DemoTopic.destroy_all


puts "create user"

admin = User.new(
  email: "admin@gmail.com",
  password: "password",
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  description: Faker::Quote.famous_last_words
)

admin.photo.attach(
  io: URI.open(Faker::Avatar.image),
  filename: "#{admin.email}.png",
  content_type: 'image/png'
)
admin.save

# 20.times do
#   all_users = User.new(
#     email: Faker::Internet.unique.email,
#     password: "password",
#     first_name: Faker::Name.unique.first_name,
#     last_name: Faker::Name.unique.last_name,
#     description: Faker::Quote.famous_last_words
#   )

#   all_users.photo.attach(
#     io: URI.open(Faker::Avatar.image),
#     filename: "#{all_users.email}.png",
#     content_type: 'image/png'
#   )
#   all_users.save
# end

# Faker::Name.unique.clear

# puts "create demonstrations"
# locations = [
#   {
#     postcode: '10117',
#     location: 'Unter den Linden 77-80, 10117 Berlin, Germany'
#   },
#   {
#     postcode: '10963',
#     location: 'Stresemannstraße 110, 10963 Berlin, Germany'
#   },
#   {
#     postcode: '10435',
#     location: 'Schönhauser Allee 80, 10435 Berlin, Germany'
#   },
#   {
#     postcode: '10785',
#     location: 'Potsdamer Platz 1, 10785 Berlin, Germany'
#   },
#   {
#     postcode: '10179',
#     location: 'Mühlenstraße 78-80, 10179 Berlin, Germany'
#   },
#   {
#     postcode: '10117',
#     location: 'Leipziger Platz 12, 10117 Berlin, Germany'
#   },
#   {
#     postcode: '10115',
#     location: 'Invalidenstraße 50-51, 10115 Berlin, Germany'
#   },
#   {
#     postcode: '10969',
#     location: 'Köpenicker Str. 1, 10969 Berlin, Germany'
#   },
#   {
#     postcode: '10117',
#     location: 'Bebelplatz, 10117 Berlin, Germany'
#   },
#   {
#     postcode: '10437',
#     location: 'Danziger Str. 5, 10437 Berlin, Germany'
#   }
# ]
# # alluser_array = []

# all_user = User.all
# # all_user.each do |user|
# #   alluser_array << user
# # end

# 10.times do |i|
#   time = (Time.now + rand(1..10).days)
#   demonstration = Demonstration.new(
#     user_id: all_user.sample.id,
#     title: Faker::Book.title,
#     description: Faker::Quote.famous_last_words,
#     location: locations[i][:location],
#     # location: Faker::Address.street_name,
#     postcode: locations[i][:postcode], # Faker::Address.zip_code,
#     city: "Berlin",
#     country: "Germany",
#     latitude: 420.420,
#     longitude: 420.420,
#     start_time: time,
#     end_time: (time + rand(1..10).hours),
#     extra_info: Faker::Fantasy::Tolkien.poem,
#     active: true
#   )

#   demonstration.photo.attach(
#     io: URI.open(Faker::Avatar.image),
#     filename: "#{demonstration.title}.png",
#     content_type: 'image/png'
#   )
#   demonstration.save
# end

# puts "create bookmarks"

# Bookmark.create!(
#   user_id: User.last.id,
#   demonstration_id: Demonstration.last.id
# )

# puts "create types"

# Type.create!(
#   name: "rally",
#   description: "This is through a rally"
# )

# Type.create!(
#   name: "bike",
#   description: "This is on a bike"
# )

# all_types = %w[war freedom racism education enviorment climate frank lgbtq legislation]

# all_types.each do |type|
#   Type.create(
#     name: type,
#     description: "This is about #{type}"
#   )
# end

# all_topics = %w[rally bike speech march sitin online hungerstrike boycott strikes frank artisticprotest]

# all_topics.each do |topic|
#   Topic.create(
#     name: topic,
#     description: "This is about #{topic}"
#   )
# end

# puts "create demo_types"
# 20.times do
#   DemoType.create!(
#     demonstration_id: Demonstration.all.sample.id,
#     type_id: Type.all.sample.id
#   )
# end

# puts "create demo_topics"
# 20.times do
#   DemoTopic.create!(
#     demonstration_id: Demonstration.all.sample.id,
#     topic_id: Topic.all.sample.id
#   )
# end
