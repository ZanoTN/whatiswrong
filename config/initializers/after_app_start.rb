Rails.application.config.after_initialize do
  next if defined?(Rails::Console)
  next if ENV["SECRET_KEY_BASE_DUMMY"] == "1"

  AfterAppStart.run
end
