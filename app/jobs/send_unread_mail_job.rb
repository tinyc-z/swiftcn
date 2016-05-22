class SendUnreadMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user_id)
    user = User.find_by_id(user_id)
    if user.present? && user.unread_notification_count > 0
      Notifier.send_unread_email(user)
    end
  end
end