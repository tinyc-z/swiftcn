class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.desc.page(params_page)
    if current_user.unread_notification_count > 0
      current_user.update_column(:unread_notification_count,0)
    end
  end

  def unread_count
    render :json => {unread: current_user ? current_user.unread_notification_count : 0}  
  end
  
end
