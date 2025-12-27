Rails.application.config.after_initialize do
  next if defined?(Rails::Console)
  next unless Rails.const_defined?(:Server)

  AfterAppStart.run
end