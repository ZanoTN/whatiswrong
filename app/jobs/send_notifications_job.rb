class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find_by(id: message_id)
    return unless message

    app_notifications = AppNotification.where(app_id: message.app.id)

    app_notifications.each do |app_notification|
      begin
        app_notification.send_message(message)
      rescue => e
        Rails.logger.error(
          "Failed to send notification ##{app_notification.id} for message ##{message.id}: #{e.message}"
        )
      end
    end
  end
end
