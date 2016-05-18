class SendWelcomeMailJob < ActiveJob::Base
  queue_as :send_mail

  def perform(user_id)
    user = User.find_by_id(user_id)
    if user
      user.send_welcome_mail
    end
  end
end