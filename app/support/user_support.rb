class UserSupport
  def user_types
    @user_types = Decentralization.pluck(:name, :id)
  end
  def report
    @report = Report.new
  end
  def users user
    @users = user.following
  end
  def followers user
    @followers = user.followers
  end
  def posts user, current_user, page
    if user == current_user
      @posts = user.posts.order_created_at.page(page).per(5)
    elsif current_user.following?(user)
      @posts = user.posts.check_status.order_created_at.page(page).per(5)
    else
      @posts = user.posts.check_status_public.order_created_at.page(page).per(5)
    end
  end
  def users_index
    @users = User.order_created_at.page(params[:page]).per(5)
  end
end
