# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
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

20.times do
  all_users = User.new(
    email: Faker::Internet.unique.email,
    password: "password",
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    description: Faker::Quote.famous_last_words
  )

  all_users.photo.attach(
    io: URI.open(Faker::Avatar.image),
    filename: "#{all_users.email}.png",
    content_type: 'image/png'
  )
  all_users.save
end

Faker::Name.unique.clear

puts "create demonstrations"
# alluser_array = []

  all_user = User.all
# all_user.each do |user|
#   alluser_array << user
# end

20.times do
  time = (Time.now + rand(1..10).days)
  demonstration = Demonstration.new(
    user_id: all_user.sample.id,
    title: Faker::Book.title,
    description: Faker::Quote.famous_last_words,
    location: Faker::Address.street_name,
    postcode: Faker::Address.zip_code,
    city: "Berlin",
    country: "Germany",
    latitude: 420.420,
    longitude: 420.420,
    start_time: time,
    end_time: (time + rand(1..10).hours),
    extra_info: Faker::Fantasy::Tolkien.poem,
    active: true
  )

  demonstration.photo.attach(
    io: URI.open(Faker::Avatar.image),
    filename: "#{demonstration.title}.png",
    content_type: 'image/png'
  )
  demonstration.save
end

puts "create bookmarks"

Bookmark.create!(
  user_id: User.last.id,
  demonstration_id: Demonstration.last.id
)

puts "create types"

Type.create!(
  name: "rally",
  description: "This is through a rally"
)

Type.create!(
  name: "bike",
  description: "This is on a bike"
)


puts "create topics"
Topic.create!(
  name: "freedom",
  description: "this is about freedom"
)

Topic.create!(
  name: "war",
  description: "This is about war"
)

puts "create demo_types"
20.times do
  DemoType.create!(
    demonstration_id: Demonstration.all.sample.id,
    type_id: Type.all.sample.id
  )
end

puts "create demo_topics"
20.times do
  DemoTopic.create!(
    demonstration_id: Demonstration.all.sample.id,
    topic_id: Topic.all.sample.id
  )
end
