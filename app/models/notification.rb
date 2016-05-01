# -*- encoding : utf-8 -*-
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

class Notification < ActiveRecord::Base

  belongs_to :user, :counter_cache => true
  has_one :from_user,class_name: 'User', foreign_key: :from_user_id

  has_one :topic
  has_one :reply

end
