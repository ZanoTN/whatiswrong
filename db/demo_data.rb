# Generate a demo data file for testing purposes


def clean_all_database
  puts "Cleaning database..."

  User.destroy_all
  Message.destroy_all
  App.destroy_all

  puts "Database cleaned."
end

def generate_demo_data
  puts "Generating demo data..."

  # Create demo user
  User.create!( username: "demo", password: "password" )

  app_names = generate_unique_app_names(12)

  # Generate 7 demo applications with messages
  app_names.each do |name|
    app = App.create!( name: name ) #

    # Generate X messages for each app
    random_message_count = rand(80..120)

    random_message_count.times do |j|
       Message.create(
        app: app,
        message: Faker::Lorem.sentence(word_count: 10),
        context: random_context(),
        level: %w[info warning error error error error].sample,
        backtrace: Faker::Lorem.paragraph(sentence_count: 3),

        # Generate a random timestamp within the last 30 days
        occurred_at: Faker::Time.between(from: DateTime.now - 31, to: DateTime.now)
      )
    end
  end

  puts "Demo data generation complete."
end

def generate_unique_app_names(number_of_names)
  app_names = Set.new

  while app_names.size < number_of_names
    app_names.add(Faker::App.name) #Faker::Movies::LordOfTheRings.location
  end

  app_names.to_a
end

def random_context
  {
    user_id: rand(1..1000),
    session_id: Faker::Alphanumeric.alphanumeric(number: 10),
    token: Faker::Alphanumeric.alphanumeric(number: 15),
    feature_flag: ["new_ui", "beta_feature", "dark_mode"].sample
  }
end


clean_all_database
generate_demo_data
