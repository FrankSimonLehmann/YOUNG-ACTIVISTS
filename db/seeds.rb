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

user = User.create!(
  email: "admin@gmail.com",
  password: "password",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  description: Faker::Quote.famous_last_words
)

demonstration = Demonstration.create!(
  user_id: user.id,
  title: "lol",
  description: "lololololololol",
  location: "lol",
  postcode: "20",
  city: "lol",
  country: "lol",
  latitude: 420.420,
  longitude: 420.420,
  start_time: Time.now,
  end_time: Time.now,
  extra_info: "lol",
  active: true
)

Bookmark.create!(
  user_id: user.id,
  demonstration_id: demonstration.id
)

type = Type.create!(
  name: "frank",
  description: "frank"
)

topic = Topic.create!(
  name: "frank",
  description: "frank"
)

DemoType.create!(
  demonstration_id: demonstration.id,
  type_id: type.id
)

DemoTopic.create!(
  demonstration_id: demonstration.id,
  topic_id: topic.id
)
