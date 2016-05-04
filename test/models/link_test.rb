# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  title      :string(191)
#  link       :string(191)
#  cover      :string(191)
#  sort       :integer          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
