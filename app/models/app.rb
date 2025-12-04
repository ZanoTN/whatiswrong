class App < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(24) # 48 characters
    Rails.logger.info "Generated API key for App #{self.name}, api_key: #{self.api_key}"
  end
end
