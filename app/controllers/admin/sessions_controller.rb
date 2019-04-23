class Admin::SessionsController < Admin::BaseController
  skip_before_action :admin_check_log_in
  before_action :admin_check_log_out, only: [:new, :create]
  def new;  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        if user.user_type == 1
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_to admin_user_path(user)
        else
          flash[:danger] = "Ban khong co quyen truy cap!"
          redirect_to admin_log_in_path
        end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to admin_root_path
      end
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to admin_log_in_path
    end
  end

  def destroy
    log_out
    redirect_to admin_log_in_path
  end

end
