# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  title              :string(191)      not null
#  body               :text(65535)
#  body_original      :text(65535)
#  excerpt            :text(65535)
#  is_excellent       :boolean          default(FALSE)
#  is_wiki            :boolean          default(FALSE)
#  is_blocked         :boolean          default(FALSE)
#  replies_count      :integer          default(0)
#  view_count         :integer          default(0)
#  favorites_count    :integer          default(0)
#  votes_count        :integer          default(0)
#  last_reply_user_id :integer
#  order              :integer          default(0)
#  node_id            :integer          not null
#  user_id            :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#

FactoryGirl.define do
  factory :topic do
    title Faker::Lorem.sentence 
    body_original Faker::Lorem.paragraph
    user_id {FactoryGirl.create(:user).id}
    node_id {FactoryGirl.create(:node).id}
  end
end
