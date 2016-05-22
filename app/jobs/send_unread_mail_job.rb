class SendUnreadMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user)
    logger.debug "my-debug: user=#{user}"
    logger.debug "my-debug: unread_notification_count=#{user.unread_notification_count}"
    if user && user.unread_notification_count > 0
      
      res = Notifier.send_unread_email(user)
      logger.debug "my-debug: res=#{res}"
    end
  end
end