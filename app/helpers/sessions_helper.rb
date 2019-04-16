module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    user.update status: 1
  end

  def log_in?
    current_user.present?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def log_out
    current_user.update status: 2
    forget(current_user)
    session.delete :user_id
    @current_user = nil
  end

  def admin_user
    return current_user.user_type == 1
    flash[:warning] = "m"
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
