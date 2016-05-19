class SendUnreadMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user)
    if user && user.unread_notification_count > 0
      Notifier.send_unread_email(user)
    end
  end
end