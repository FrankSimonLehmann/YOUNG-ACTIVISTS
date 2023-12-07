# Everyday at 12:45 we do a background job (chrome extension)
namespace :demonstrations do
  desc "Update all demonstrations"
  task update_all: :environment do
    db_berlin = "https://www.berlin.de/polizei/service/versammlungsbehoerde/versammlungen-aufzuege/index.php/index/all.json?q="
      db_berlin_serialized = URI.open(db_berlin).read
      berlin_demos = JSON.parse(db_berlin_serialized)
      puts "#{berlin_demos["results"]["count"]}"
      puts "#{berlin_demos["index"][0]["thema"]}"


  Demonstration.create!(
    user: User.last,
    title: "test",
    description: berlin_demos["index"][0]["thema"],
    location: berlin_demos["index"][0]["strasse_nr"],
    postcode: berlin_demos["index"][0]["plz"],
    start_time: Time.now,
    end_time: Time.now + 1.hour
  )
  # If there are new demo's we add them to the database
  # compare the id of the demo to the id in our database (if it exists)
  # else we do nothing
end
end
