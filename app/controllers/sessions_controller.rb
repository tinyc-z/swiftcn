class Users::SessionsController < Devise::SessionsController
  
  # GET /resource/sign_in
  def new
    binding.pry
    super
  end

  # POST
  def create

  end

end