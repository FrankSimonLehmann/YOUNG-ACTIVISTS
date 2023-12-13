# Everyday at 12:45 we do a background job (chrome extension)
namespace :demonstrations do
  desc "Update"
  task update_all: :environment do
    db_berlin = "https://www.berlin.de/polizei/service/versammlungsbehoerde/versammlungen-aufzuege/index.php/index/all.json?q="
    db_berlin_serialized = URI.open(db_berlin).read
    berlin_demos = JSON.parse(db_berlin_serialized)

    # Iteration for all the demos

    berlin_demos["index"].each do |demo|

      # Extract date and time strings from the API data
      date_str = demo["datum"]
      time_from_str = demo["von"]
      time_to_str = demo["bis"]
      thema = demo["thema"]

      # Parse date and time strings and create a Time instance
      date_parts = date_str.split('.').map(&:to_i)
      day, month, year = date_parts
      time_from_parts = time_from_str.split(':').map(&:to_i)
      time_to_parts = time_to_str.split(':').map(&:to_i)

      event_time_from = Time.new(year, month, day, *time_from_parts)
      event_time_to = Time.new(year, month, day, *time_to_parts)

      # only create a new demonstration if the thema is not included in the current database & the date is not in the past & the date is before current date + 1 year
      if Demonstration.find_by(thema: thema).nil? && event_time_from > Time.now && event_time_from < Time.now + 1.year

        # Create a new demo based on the API data we received and assign the admin to it
        new_demo = Demonstration.new(
          user: User.first,
          thema: demo["thema"],
          location: demo["strasse_nr"],
          city: "Berlin",
          country: "Germany",
          postcode: demo["plz"],
          start_time: event_time_from,
          end_time: event_time_to
        )

        p (new_demo)
        # Create a new demo based on the API data we received and assign the admin to it
        client = OpenAI::Client.new
        chaptgpt_description = client.chat(parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: "Give me a description of max 100 words and minimum 50 words in English based on the following description of a demonstration in Berlin #{new_demo.thema}. Give me only the text, without any of your own answer like 'Here is a description for'. Please write in the future tense, because the demonstrations have not happened yet"}]
        })

        new_demo.description = chaptgpt_description["choices"][0]["message"]["content"]
        p (new_demo.description)

        client = OpenAI::Client.new
        chaptgpt_title = client.chat(parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: "Give me a title of max 48 letters (including spaces) in English based on the following description of a demonstration #{new_demo.description}. Give me only the text of the title, without any of your own answer like 'Here is a title for'. Please write in the future tense, because the demonstrations have not happened yet. Please make 100% sure that the title is maximum of 48 letters (including spaces)."}]
        })
        new_demo.title = chaptgpt_title["choices"][0]["message"]["content"].gsub(/"/, '')
        p (new_demo.title)

        new_demo.save

        client = OpenAI::Client.new
        chaptgpt_topics = client.chat(parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: "Select a maximum of two labels out of the following array [technology, feminism, education, discrimination, freedom, alternative-lifestyle, war, climate, LGTBQ, anti-government, public-space, other] that best fit the description of a demonstration #{new_demo.description}. Give me only the text of the labels, without any of your own answer like 'Here are the labels for'. Please be extra conservative in your decision. If you are not sure, please return the value other. IN NO CASE SHOULD YOU RETURN A VALUE THAT IS NOT INSIDE OF THE ARRAY"}]
        })

        topics = chaptgpt_topics["choices"][0]["message"]["content"]

        array_of_topics = topics.split(',').map(&:strip)
        p array_of_topics

        array_of_topics.each do |topic|
          topic_id = Topic.find_by(name: topic).id
          p topic_id
          DemoTopic.create(demonstration_id: new_demo.id, topic_id: topic_id)
        end

        client = OpenAI::Client.new
        chaptgpt_types = client.chat(parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: "Select a maximum of 1 label out of the following array [physical demo, collective actions, digital demonstrations, creative expressions] that best fit the description of a demonstration #{new_demo.description}. Give me only the text of the labels, without any of your own answer like 'Here are the labels for'. Please be extra conservative in your decision. If you are not sure, please return the value other."}]
        })

        types = chaptgpt_types["choices"][0]["message"]["content"]

        array_of_types = types.split(',').map(&:strip)
        p array_of_types

        array_of_types.each do |type|
          type_id = Type.find_by(name: type).id
          p type_id
          DemoType.create(demonstration_id: new_demo.id, type_id: type_id)
        end
      else
        puts "already in database"
      end
    end
  end
end
