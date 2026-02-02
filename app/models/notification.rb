# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(TRUE), not null
#  configuration :jsonb            not null
#  name          :string           not null
#  service       :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Notification < ApplicationRecord
  store_accessor :configuration,
    :chat_id,
    :bot_token,
    :webhook_url

  has_many :app_notifications, dependent: :destroy

  validates :service, presence: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validate :validate_configuration

  enum :service, {
    telegram: "telegram",
    discord: "discord"
  }

  private

  def validate_configuration
    send("validate_#{service}_configuration")
  rescue NoMethodError
    errors.add(:service, :invalid)
  end

  def validate_telegram_configuration
    validates_presence_of :chat_id, :bot_token
  end

  def validate_discord_configuration
    validates_presence_of :webhook_url
  end
end
