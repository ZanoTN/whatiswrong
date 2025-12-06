# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
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
#  app_id  (app_id => apps.id)
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
