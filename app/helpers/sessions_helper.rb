module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    user.update status: true
  end

  def log_in?
    current_user.present?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by id: session[:user_id]
    end
  end

  def log_out
    @current_user.update status: false
    session.delete :user_id
    @current_user = nil
  end

  def admin_user
    return current_user.user_type == 1
    flash[:warning] = "m"
  end

end
