class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    omniauth = session[:omniauth]
    if omniauth.present?
      @nickname = omniauth["nickname"]
      @name = @nickname.present? ? @nickname : omniauth["nickname"]
      @emails = omniauth["emails"]
      @avatar = omniauth["avatar"]
      @user = User.new(name:@name)
    else
      redirect_to root_path  
    end
  end

  # POST /resource
  # https://robohash.org/etesseofficiis.png?size=300x300&set=set1
  def create
    omniauth = session[:omniauth]
    authentication = Authentication.where(provider: omniauth["provider"], uid: omniauth["uid"].to_s).first
    if authentication.user.blank?
      user = User.new(sign_up_params.merge(email:params[:email],avatar:params[:avatar]))
      #先设置远程图片，然后延迟下载
      user.transaction do
        user.save!
        authentication.user = user
        authentication.save!
        sign_in(:user, user)
        
        UserAvatarDownloaderJob.perform_later user 
        SendWelcomeMailJob.set(wait: 10.minute).perform_later user
        
      end
    end
    redirect_to root_path
  end

  # GET /resource/edit
  def edit
  end

  # PUT /resource
  def update
  end

  # DELETE /resource
  def destroy
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name,:password)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
