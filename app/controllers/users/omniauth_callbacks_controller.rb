class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:github]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def github
    omniauth_process
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
    super
  end

  protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def omniauth_process

    if current_user
      sign_out(:user, current_user)
    end

    omniauth = request.env['omniauth.auth']
    info = omniauth.except("extra")["info"]

    authentication = Authentication.find_or_initialize_by(provider: omniauth.provider, uid: omniauth.uid.to_s)
    authentication.access_token = omniauth.credentials.token
    authentication.uname = info["nickname"]
    authentication.save

    if authentication.user
      # set_flash_message(:notice, :signed_in)
      sign_in(:user, authentication.user)
      redirect_to root_path
    else
      raw_info = omniauth.except("info")["extra"]["raw_info"]
      session[:omniauth] = {
        avatar: info["image"],
        nickname: info["nickname"],
        name: info["name"],
        emails: [info["email"],(raw_info ? raw_info["email"] : nil)].compact,
        uid: omniauth.uid,
        provider: omniauth.provider,
        access_token: omniauth.credentials.token,
      }
      # set_flash_message(:notice, :fill_your_email)
      redirect_to new_user_registration_path
    end
  end
end
