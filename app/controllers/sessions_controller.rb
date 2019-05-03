class SessionsController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  before_action :check_log_out, only: [:new, :create]
  def new;  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
          if user.status == "blocked"
            flash[:warning] = "Your account is blocked. Contact to Admin."
            redirect_to sign_in_path
          else
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_to user
          end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if log_in?
    redirect_to root_path
  end

end
