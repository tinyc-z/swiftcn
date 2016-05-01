# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: authentications
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  uid          :integer
#  provider     :string(191)      not null
#  access_token :string(191)
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
