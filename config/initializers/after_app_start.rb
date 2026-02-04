if defined?(Puma)
  Rails.application.config.after_initialize do
    AfterAppStart.run
  end
end
