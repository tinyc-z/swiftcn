# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  topic_id      :integer
#  body          :text(65535)
#  body_original :text(65535)
#  is_blocked    :boolean          default("0")
#  votes_count   :integer          default("0")
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
