class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def authenticate_user!
    if request.format == :js
        render "_partials/_redirect_login" unless user_signed_in?
    else
      super
    end
  end

  def params_id
    params[:id]
  end


  # if Rails.env.development?
  #   before_filter :fake_sign_in
  #   def fake_sign_in
  #     sign_in(:user, User.find(1)) if !user_signed_in?
  #   end
  # end

end
