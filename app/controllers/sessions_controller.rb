class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      ##if user.activated?
      log_in user
      puts params[:session][:email].downcase
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      authenicated_user_login_redirection
      #else
      #  message  = "Account not activated. "
      #  message += "Check your email for the activation link."
      #  flash[:warning] = message
      #  redirect_to activate_account_url
      #end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end