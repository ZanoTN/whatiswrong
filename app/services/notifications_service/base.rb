require "faraday"

module NotificationsService
  class Base
    def self.get_message_url(message)
      if Rails.application.config.default_host.nil?
        raise "Default host is not configured, set the `default_host` configuration option"
      end


      url = Rails.application.routes.url_helpers.message_url(
        message,
        host: Rails.application.config.default_host
      )

      # Check if run https or http
      if Rails.application.config.force_ssl
        url.gsub!("http://", "https://")
      end

      url
    end
  end
end
