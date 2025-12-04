class Message < ApplicationRecord
  belongs_to :app

  validates :content, presence: true
  validates :level, presence: true

  enum :level, {
    info: 'info',
    warning: 'warning',
    error: 'error',
    critical: 'critical',
    unknown: 'unknown'
  }
end
