# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(191)      default(""), not null
#  encrypted_password        :string(191)      default(""), not null
#  name                      :string(191)      not null
#  is_banned                 :boolean          default(FALSE), not null
#  avatar                    :string(191)
#  password                  :string(191)      default("0"), not null
#  topics_count              :integer          default(0), not null
#  replies_count             :integer          default(0), not null
#  notifications_count       :integer          default(0), not null
#  city                      :string(191)
#  company                   :string(191)
#  twitter_account           :string(191)
#  personal_website          :string(191)
#  signature                 :string(191)
#  introduction              :string(191)
#  deleted_at                :datetime
#  reset_password_token      :string(191)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0), not null
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(191)
#  last_sign_in_ip           :string(191)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  role_id                   :integer
#  unread_notification_count :integer          default(0)
#

FactoryGirl.define do
  factory :user do
    name Pinyin.t(Faker::Name.name, splitter: '')
    email Faker::Internet.email
    avatar Faker::Avatar.image
  end
end
