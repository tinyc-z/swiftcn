# == Schema Information
#
# Table name: site_statuses
#
#  id          :integer          not null, primary key
#  day_at      :datetime
#  user_count  :integer          default("0")
#  topic_count :integer          default("0")
#  reply_count :integer          default("0")
#  image_count :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  vote_count  :integer          default("0")
#

require 'test_helper'

class SiteStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
