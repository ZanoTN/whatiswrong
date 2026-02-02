# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  backtrace   :text
#  context     :text
#  level       :string           not null
#  message     :string           not null
#  occurred_at :datetime         not null
#  readed_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  app_id      :integer          not null
#
# Indexes
#
#  index_messages_on_app_id  (app_id)
#
# Foreign Keys
#
#  fk_rails_...  (app_id => apps.id)
#
class Message < ApplicationRecord
  belongs_to :app

  validates :message, presence: true
  validates :level, presence: true

  enum :level, {
    info: "info",
    warning: "warning",
    error: "error"
  }

  before_validation do
    self.context = Message.parse_json_to_string(self.context)
    self.backtrace = Message.parse_json_to_string(self.backtrace)
  end

  before_create do
    if self.occurred_at.nil?
      self.occurred_at = DateTime.now
    end
  end

  after_create do
    update_last_used_at_app
    send_notifications
  end

  def readed?
    !self.readed_at.nil?
  end

  def send_notifications
    app_notifications = AppNotification.where(app_id: app.id)
    app_notifications.each do |app_notification|
      begin
        app_notification.send_message(self)
      rescue => e
        Rails.logger.error("Failed to send notification ##{app_notification.id} for message ##{id}: #{e.message}")
      end
    end
  end

  private

  def update_last_used_at_app
    #  Prevent updating last_used_at too often
    if !app.last_used_at.nil? && app.last_used_at > 5.minutes.ago
      return
    end

    app.last_used_at = DateTime.now
    app.save(validate: false)
  end

  def self.parse_json_to_string(value)
    return nil if value.nil?

    if value.is_a?(String)
      begin
        JSON.parse(value)
        value
      rescue JSON::ParserError
        value
      end
    else
      JSON.generate(value)
    end
  end
end
