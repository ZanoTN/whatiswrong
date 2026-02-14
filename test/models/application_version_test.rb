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
require "test_helper"

class ApplicationVersionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
