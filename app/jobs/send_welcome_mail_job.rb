class SendWelcomeMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user_id)
    user = User.find_by_id(user_id)
    if user.present?
      Notifier.send_welcome_email(user)   
    end
  end
end