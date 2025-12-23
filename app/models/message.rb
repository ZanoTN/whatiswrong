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
    info: 'info',
    warning: 'warning',
    error: 'error',
  }

  before_create do
    if self.occurred_at.nil?
      self.occurred_at = DateTime.now
    end
  end

  after_create do
    app.last_used_at = DateTime.now
    app.save!
  end
end
