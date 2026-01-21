require "cgi"

module NotificationsService
  class Telegram < Base
    def self.send_message(notification, message)
      if notification.bot_token.blank? || notification.chat_id.blank?
        raise ArgumentError, "Invalid Telegram notification configuration"
      end

      url = "https://api.telegram.org/bot#{notification.bot_token}/sendMessage"

      #  Create message text
      message_text = ""

      case message.level
      when "info"
        message_text += "ℹ️"
      when "warning"
        message_text += "⚠️"
      when "error"
        message_text += "❌"
      else
        message_text += "❓"
      end

      message_text << " <b>#{CGI.escapeHTML(message.app.name.to_s)}</b>\n"
      message_text << CGI.escapeHTML(message.message.to_s)

      params = {
        chat_id: notification.chat_id,
        text: message_text,
        parse_mode: "HTML",
        reply_markup: {
          inline_keyboard: [
            [
              { text: "More details", url: self.get_message_url(message) }
            ]
          ]
        }.to_json
      }

      if Rails.env.test? || Rails.env.development?
        Rails.logger.info("Telegram notification (test/development mode): #{params.inspect}")
        return
      end

      response = Faraday.post(url, params)
      unless response.success?
        raise "Failed to send Telegram notification: #{response.status} - #{response.body}"
      end
    end
  end
end
