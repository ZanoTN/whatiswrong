# == Schema Information
#
# Table name: settings
#
#  id            :bigint           not null, primary key
#  default_theme :string           default("light"), not null
#  language      :string           default("en"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Setting < ApplicationRecord
  validates :default_theme, presence: true
  validates :language, presence: true

  enum :default_theme, { light: 'light', dark: 'dark' }, suffix: true
  enum :language, { en: 'en' }, suffix: true
end
