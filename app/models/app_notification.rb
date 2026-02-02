# == Schema Information
#
# Table name: app_notifications
#
#  id              :bigint           not null, primary key
#  level_error     :boolean          default(FALSE)
#  level_info      :boolean          default(FALSE)
#  level_warning   :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  app_id          :bigint           not null
#  notification_id :bigint           not null
#
# Indexes
#
#  index_app_notifications_on_app_id                      (app_id)
#  index_app_notifications_on_app_id_and_notification_id  (app_id,notification_id) UNIQUE
#  index_app_notifications_on_notification_id             (notification_id)
#
# Foreign Keys
#
#  fk_rails_...  (app_id => apps.id)
#  fk_rails_...  (notification_id => notifications.id)
#
class AppNotification < ApplicationRecord
  belongs_to :app
  belongs_to :notification

  def send_message(message)
    if !notification.active
      Rails.logger.info("Notification ##{id} is inactive, skipping sending message")
      return
    end

    if message.level == "info" && !level_info
      Rails.logger.info("Notification ##{id} is not configured to send info messages, skipping")
      return
    end

    if message.level == "warning" && !level_warning
      Rails.logger.info("Notification ##{id} is not configured to send warning messages, skipping")
      return
    end

    if message.level == "error" && !level_error
      Rails.logger.info("Notification ##{id} is not configured to send error messages, skipping")
      nil
    end

    # Send message via the appropriate service
    case notification.service
    when "telegram"
      NotificationsService::Telegram.send_message(notification, message)
    when "discord"
      NotificationsService::Discord.send_message(notification, message)
    else
      raise "Unsupported notification service: #{service}"
    end
  end
end
