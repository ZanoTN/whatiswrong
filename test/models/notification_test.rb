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
require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
