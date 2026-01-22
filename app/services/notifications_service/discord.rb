require "cgi"

module NotificationsService
  class Discord < Base
    def self.send_message(notification, message)
      if notification.webhook_url.blank?
        raise ArgumentError, "Invalid Discord notification configuration"
      end

      params = {
        "content": nil,
        "embeds": [
          {
            "title": "#{message.app.name.upcase} - #{message.message}",
            "url": get_message_url(message),
            "color": get_message_color(message),
            "fields": [
              {
                "name": "Level:",
                "value": "#{message.level.upcase}",
                "inline": true
              },
              {
                "name": "Occurred at:",
                "value": ApplicationHelper.format_datetime(message.occurred_at),
                "inline": true
              }
            ]
          },
          {
            "title": "Context:",
            #  "description": "```json\n#{JSON.pretty_generate(JSON.parse(message.context), indent: '  ')}\n```",
            "description": "```json\n#{ApplicationHelper.format_json(message.context)}\n```",
            "color": get_message_color(message)
          },
          {
            "title": "Backtrace:",
            "description": "```json\n#{message.backtrace}\n```",
            "color": get_message_color(message)
          }
        ],
        "username": "WhatIsWrong BOT",
        "attachments": []
      }

      # Trim description fields to Discord limits
      params[:embeds].each do |embed|
        if embed[:description] && embed[:description].length > 4096
          embed[:description] = embed[:description][0..4090] + "\n```"
        end

        if embed[:title] && embed[:title].length > 256
          embed[:title] = embed[:title][0..250] + "..."
        end
      end

      if Rails.env.test? || Rails.env.development?
        Rails.logger.info("Discord notification (test/development mode): #{params.inspect}")
        return
      end

      response = Faraday.post(notification.webhook_url, params.to_json, "Content-Type" => "application/json")
      unless response.success?
        raise "Failed to send Discord notification: #{response.status} - #{response.body}"
      end
    end

    private

    def self.get_message_color(message)
      case message.level
      when "info"
        3447003  # Blue
      when "warning"
        16776960 # Yellow
      when "error"
        16711680 # Red
      else
        8421504  # Grey
      end
    end
  end
end
