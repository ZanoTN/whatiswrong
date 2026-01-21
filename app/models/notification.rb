# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(TRUE), not null
#  configuration :jsonb            not null
#  level_error   :boolean          default(TRUE), not null
#  level_info    :boolean          default(TRUE), not null
#  level_warning :boolean          default(TRUE), not null
#  name          :string           not null
#  service       :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Notification < ApplicationRecord
    store_accessor :configuration,
      :chat_id,
      :bot_token

  validates :service, presence: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  enum :service, {
    telegram: "telegram"
  }

  validate :validate_configuration

  def send_message(message)
    if !active
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
    case service
    when "telegram"
      NotificationsService::Telegram.new.send_message(self, message)
    else
      raise "Unsupported notification service: #{service}"
    end
  end

  private

  def validate_configuration
    send("validate_#{service}_configuration")
  rescue NoMethodError
    errors.add(:service, :invalid)
  end

  def validate_telegram_configuration
    validates_presence_of :chat_id, :bot_token
  end
end
