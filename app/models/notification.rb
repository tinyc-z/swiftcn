# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  user_id      :integer
#  topic_id     :integer
#  entity_id     :integer
#  body         :text(65535)
#  notify_type  :string(191)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Notification < ActiveRecord::Base

  belongs_to :user, :counter_cache => true
  belongs_to :from_user,class_name: 'User', foreign_key: :from_user_id

  belongs_to :topic
  belongs_to :reply ,class_name: 'Reply', foreign_key: :entity_id
  belongs_to :append ,class_name: 'Append', foreign_key: :entity_id

  validate :user_not_eq_from_user
  validate :uniq_record

  after_save :inc_user_unread_count

  before_save :build_body_digest

  protected

  def build_body_digest
    if body_changed?
      if body.nil?
        self.body_digest = body
      else
        html_string = TruncateHtml::HtmlString.new(body)
        self.body_digest = TruncateHtml::HtmlTruncator.new(html_string, {length: 240, omission: '...'}).truncate.html_safe
      end
    end
  end

  def inc_user_unread_count
    User.increment_counter(:unread_notification_count,user_id)
  end

  def uniq_record
    if Notification.exists?(user_id:user_id,from_user_id:from_user_id,topic_id:topic_id,entity_id:entity_id,notify_type:notify_type)
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
