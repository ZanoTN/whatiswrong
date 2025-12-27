# == Schema Information
#
# Table name: apps
#
#  id           :bigint           not null, primary key
#  api_key      :string           not null
#  last_used_at :datetime
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_apps_on_api_key  (api_key) UNIQUE
#  index_apps_on_name     (name) UNIQUE
#
class App < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(24) # 48 characters
  end

  def system_app?
    name == 'WhatIsWrong'
  end

  def self.system_app
    find_by(name: 'WhatIsWrong')
  end
end
