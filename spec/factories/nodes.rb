# == Schema Information
#
# Table name: nodes
#
#  id             :integer          not null, primary key
#  name           :string(191)
#  slug           :string(191)
#  parent_node_id :integer
#  topics_count   :integer          default(0)
#  sort           :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  deleted_at     :datetime
#

FactoryGirl.define do
  factory :node do
    name  { Faker::Name.name }
  end
end
