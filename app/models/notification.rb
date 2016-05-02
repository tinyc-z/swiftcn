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
  belongs_to :from_user,class_name: 'User', foreign_key: :from_user_id

  belongs_to :topic
  belongs_to :reply

  validate :user_not_eq_from_user
  validate :uniq_record

  after_save :inc_user_unread_count

  def bodyDigest(c)
    body
  end

  protected
  def inc_user_unread_count
    User.increment_counter(:unread_notification_count,user_id)
  end

  def uniq_record
    if Notification.exists?(user_id:user_id,from_user_id:from_user_id,topic_id:topic_id,reply_id:reply_id,notify_type:notify_type)
      errors.add(:user, "notification record exists!")
      false
    end
  end

  def user_not_eq_from_user
    if user_id == from_user_id
      errors.add(:user, "eq to from_user")
      false
    end
  end

end
