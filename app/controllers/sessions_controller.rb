class SessionsController < ApplicationController
  def new;  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    byebug
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to sign_in_path
    end
  end

  def destroy
    log_out if log_in?
    redirect_to sign_in_path
  end

end
