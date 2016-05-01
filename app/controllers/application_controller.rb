# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    if request.format == :js
      if user_signed_in?
        if current_user.ban?
          render "_partials/_no_permissions" 
        else
          super
        end
      else
        render "_partials/_redirect_login" 
      end
    else
      super
    end
  end

  def params_id
    params[:id]
  end

  def params_page
    {:page => params[:page]}
  end

  if Rails.env.development?
    before_filter :fake_sign_in
    def fake_sign_in
      sign_in(:user, User.find(2)) #if !user_signed_in?
    end
  end

end
