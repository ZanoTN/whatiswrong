# == Schema Information
#
# Table name: application_versions
#
#  id         :bigint           not null, primary key
#  key        :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ApplicationVersion < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  def self.set(key, value)
    record = find_or_initialize_by(key: key)
    record.value = value
    record.save!
    Rails.cache.write("app_version_#{key}", value, expires_in: 1.hour)
  end

  def self.get(key)
    Rails.cache.fetch("app_version_#{key}", expires_in: 1.hour) do
      record = find_by(key: key)
      record&.value
    end
  end
end
