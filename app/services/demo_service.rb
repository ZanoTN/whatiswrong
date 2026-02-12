class DemoService
  def self.run
    puts "Starting demo data generation..."
    clean_all_database
    generate_demo_data
  end

  private

  def self.clean_all_database
    puts "Cleaning database..."

    User.destroy_all
    Message.destroy_all
    Notification.destroy_all
    AppNotification.destroy_all
    App.destroy_all
    Setting.destroy_all

    puts "Database cleaned."
  end

  def self.generate_demo_data
    puts "Generating demo data..."

    Setting.generate_default

    # Create demo user
    User.create!(username: "demo_user", password: "demo_password")

    app_names = generate_unique_app_names(12)

    # Generate 7 demo applications with messages
    app_names.each do |name|
      app = App.create!(name: name) #

      # Generate X messages for each app
      random_message_count = rand(80..120)

      random_message_count.times do |j|
        level = %w[info warning error error error error].sample
        Message.create(
          app: app,
          message: random_message(level),
          context: random_context(),
          level: level,
          backtrace: random_backtrace(),

          # Generate a random timestamp within the last 30 days
          occurred_at: Faker::Time.between(from: DateTime.now - 31, to: DateTime.now)
        )
      end
    end

    puts "Demo data generation complete."
  end

  def self.random_message(level)
    return Faker::Lorem.sentence(word_count: 10) unless level == "error"

    error_messages = [
      "NoMethodError: undefined method `each' for nil:NilClass",
      "ArgumentError: wrong number of arguments (given 2, expected 1)",
      "ActiveRecord::RecordNotFound: Couldn't find User with 'id'=42",
      "ActiveRecord::RecordInvalid: Validation failed: Email has already been taken",
      "ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR: relation \"widgets\" does not exist",
      "ActionView::Template::Error: undefined method `title' for nil:NilClass",
      "ActionController::RoutingError: No route matches [GET] \"/api/v1/unknown\"",
      "ActionDispatch::Http::Parameters::ParseError:  unexpected token at '{bad json'",
      "Redis::CannotConnectError: Error connecting to Redis on localhost:6379 (ECONNREFUSED)",
      "Net::ReadTimeout: Net::ReadTimeout with #<TCPSocket:(closed)>"
    ]

    error_messages.sample
  end

  def self.generate_unique_app_names(number_of_names)
    app_names = Set.new

    while app_names.size < number_of_names
      new_name = Faker::App.name
      if new_name.size < 3
        new_name = new_name.ljust(3, "X")
      end
      app_names.add(Faker::App.name)
    end

    app_names.to_a
  end

  def self.random_context
    JSON.generate({
      "user_id": rand(1..1000),
      "session_id": Faker::Alphanumeric.alphanumeric(number: 10),
      "token": Faker::Alphanumeric.alphanumeric(number: 30),
      "feature_flag": [ "new_ui", "beta_feature", "dark_mode" ].sample
    })
  end

  def self.random_backtrace
    frames = []

    rand(10..20).times do
      frames << format(
        "%s:%d:in `%s'",
        Faker::File.file_name(dir: "app/#{%w[controllers models services].sample}", ext: "rb"),
        rand(10..300),
        Faker::Lorem.word
      )
    end

    frames.join("\n")
  end
end
