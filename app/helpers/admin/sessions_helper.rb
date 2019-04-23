module Admin::SessionsHelper

  def log_in user
    session[:admin_id] = user.id
    user.update status: 1
  end

  def log_in?
    current_admin.present?
  end

  def current_admin
    if session[:admin_id]
      @current_admin = User.find_by id: session[:admin_id]
    end
  end

  def current_admin? user
    current_admin == user
  end

  def log_out
    current_admin.update status: 2
    session.delete :admin_id
    @current_admin = nil
  end

  def admin_check_log_in
    return if log_in?
    flash[:danger] = "You Must Log In First!!"
    redirect_to admin_log_in_url
  end

  def admin_check_log_out
    return if !log_in?
    flash[:warning] = "You should Log Out do this"
    redirect_to admin_root_url
  end

    def admin_user
      return current_admin.user_type == 1
      flash[:warning] = "Ban khong co quyen truy cap!"
    end

end
