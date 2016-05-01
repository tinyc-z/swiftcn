# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: appends
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  content    :text(65535)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AppendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
