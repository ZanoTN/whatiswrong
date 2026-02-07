# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Setting.count.zero?
  puts "Creating default Settings record..."
  Setting.generate_default
end

if App.system_app.nil?
  puts "Creating default 'whatiswrong' App record..."
  App.create(name: "WhatIsWrong")
end
