# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  user_id      :integer
#  topic_id     :integer
#  reply_id     :integer
#  body         :text(65535)
#  notify_type  :string(191)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
