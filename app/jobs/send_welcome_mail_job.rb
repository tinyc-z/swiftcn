class SendWelcomeMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user)
    Notifier.send_welcome_email(user) if user
  end
end