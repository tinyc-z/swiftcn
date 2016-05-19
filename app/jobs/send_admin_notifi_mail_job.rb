class SendAdminNotifiMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(url)
    Notifier.send_admin_notifi(url) if url
  end
end