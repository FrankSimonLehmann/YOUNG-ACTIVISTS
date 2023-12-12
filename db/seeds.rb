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

5.times do
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
locations = [
  {
    postcode: '10117',
    location: 'Unter den Linden 77-80, 10117 Berlin, Germany'
  },
  {
    postcode: '10963',
    location: 'Stresemannstraße 110, 10963 Berlin, Germany'
  },
  {
    postcode: '10435',
    location: 'Schönhauser Allee 80, 10435 Berlin, Germany'
  },
  {
    postcode: '10785',
    location: 'Potsdamer Platz 1, 10785 Berlin, Germany'
  },
  {
    postcode: '10179',
    location: 'Mühlenstraße 78-80, 10179 Berlin, Germany'
  },
  {
    postcode: '10117',
    location: 'Leipziger Platz 12, 10117 Berlin, Germany'
  },
  {
    postcode: '10115',
    location: 'Invalidenstraße 50-51, 10115 Berlin, Germany'
  },
  {
    postcode: '10969',
    location: 'Köpenicker Str. 1, 10969 Berlin, Germany'
  },
  {
    postcode: '10117',
    location: 'Bebelplatz, 10117 Berlin, Germany'
  },
  {
    postcode: '10437',
    location: 'Danziger Str. 5, 10437 Berlin, Germany'
  }
]

title = [
  {
    title: "Earth day",
    description: "Save the planet!"
  },
  {
    title: "Stop the war in ukraine!",
    description: "Stop the war!"
  },
  {
    title: "Save the whales!",
    description: "Stop the whales from getting hunted!"
  },
  {
    title: "Protest against the new law!",
    description: "Stop the goverment from implementing this new law!"
  },
  {
    title: "Stop the racism!",
    description: "Stop the racism!"
  },
  {
    title: "Stop the killing of the animals!",
    description: "Stop the killing of the animals!"
  },
  {
    title: "Living crisis!",
    description: "Protest against the goverment for living crisis!"
  },
  {
    title: "Stop the war in syria!",
    description: "Stop the war!"
  },
  {
    title: "Stop the opression of lewagon students!",
    description: "Stop the opression!"
  },
  {
    title: "Improvement of the education system!",
    description: "Improve education!"
  }
]
# alluser_array = []

all_user = User.all
# all_user.each do |user|
#   alluser_array << user
# end



  # demonstration = Demonstration.new(
  #   user_id: all_user.sample.id,
  #   title: Faker::Book.title,
  #   description: Faker::Quote.famous_last_words,
  #   location: locations[i][:location],
  #   # location: Faker::Address.street_name,
  #   postcode: locations[i][:postcode], # Faker::Address.zip_code,
  #   city: "Berlin",
  #   country: "Germany",
  #   latitude: 420.420,
  #   longitude: 420.420,
  #   start_time: time,
  #   end_time: (time + rand(1..10).hours),
  #   extra_info: Faker::Fantasy::Tolkien.poem,
  #   active: true
  # )

  # demonstration.photo.attach(
  #   io: URI.open(Faker::Avatar.image),
  #   filename: "#{demonstration.title}.png",
  #   content_type: 'image/png'
  # )
  # demonstration.save

  10.times do |i|
    time = (Time.now + rand(1..10).days + rand(1..2).hours)
    demonstration = Demonstration.new(
      user_id: all_user.sample.id,
      title: title[i][:title],
      description: title[i][:description],
      location: locations[i][:location],
      postcode: locations[i][:postcode],
      city: "Berlin",
      country: "Germany",
      latitude: 420.420,
      longitude: 420.420,
      start_time: time,
      end_time: (time + rand(1..5).hours),
      extra_info: "Bring your own signs!",
      active: true
    )
    puts demonstration.start_time
    demonstration.save
  end


puts "create bookmarks"

Bookmark.create!(
  user_id: User.first.id,
  demonstration_id: Demonstration.last.id
)

puts "create types"

Type.create!(
  name: "physical demo",
  description: "This is about physical demo",
  color: "type_color"
)

Type.create!(
  name: "collective actions",
  description: "This is about collective actions",
  color: "type_color"
)
Type.create!(
  name: "digital demonstrations",
  description: "This is about digital demonstrations",
  color: "type_color"
)

Type.create!(
  name: "creative expressions",
  description: "This is about creative expressions",
  color: "type_color"
)

puts "create topics"
Topic.create!(
  name: "technology",
  description: "This is about technology",
  color: "technology_color"
)

Topic.create!(
  name: "feminism",
  description: "This is about feminism",
  color: "feminism_color"
)

Topic.create!(
  name: "education",
  description: "This is about education",
  color: "education_color"
)

Topic.create!(
  name: "discrimination",
  description: "This is about discrimination",
  color: "discrimination_color"
)

Topic.create!(
  name: "freedom",
  description: "This is about freedom",
  color: "freedom_color"
)

Topic.create!(
  name: "alternative-lifestyle",
  description: "This is about alternative lifestyle",
  color: "alternative-lifestyle_color"
)

Topic.create!(
  name: "war",
  description: "This is about war",
  color: "war_color"
)

Topic.create!(
  name: "climate",
  description: "This is about climate",
  color: "climate_color"
)

Topic.create!(
  name: "LGTBQ",
  description: "This is about LGTBQ",
  color: "LGTBQ_color"
)

Topic.create!(
  name: "anti-government",
  description: "This is about anti-government",
  color: "anti-government_color"
)

Topic.create!(
  name: "public-space",
  description: "This is about public space",
  color: "public-space_color"
)

Topic.create!(
  name: "other",
  description: "This is about other",
  color: "other_color"
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
