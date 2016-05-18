class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find 23
    @notifications = user.notifications.paginate(params_page)
    if user.unread_notification_count > 0
      user.update_column(:unread_notification_count,0)  
    end
  end

  def unread_count
    render :json => {unread: current_user ? current_user.unread_notification_count : 0}  
  end
  
end
