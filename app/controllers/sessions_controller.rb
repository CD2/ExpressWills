class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if user.admin
        redirect_to admin_wills_path
      else
        redirect_back_or new_will_path
      end
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end