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
  def posts user, current_user
    if user == current_user
      @posts = user.posts.order_created_at
    elsif current_user.following?(user)
      @posts = user.posts.where("status = 1 or status = 2").order_created_at
    else
      @posts = user.posts.where("status = 1").order_created_at
    end
  end
  def users_index
    @users = User.order_created_at
  end
end
