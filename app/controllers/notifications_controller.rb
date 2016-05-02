# -*- encoding : utf-8 -*-
class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find 28
    @notifications = user.notifications.paginate(params_page)
  end
  
end
