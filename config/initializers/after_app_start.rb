Rails.application.config.after_initialize do
  next unless Rails.server?

  AfterAppStart.run
end