# == Schema Information
#
# Table name: apps
#
#  id           :integer          not null, primary key
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
require "test_helper"

class AppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
