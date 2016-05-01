# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AttentionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
