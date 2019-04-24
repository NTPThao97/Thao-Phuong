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
  def posts user
    @posts = user.posts.order_created_at
  end
  def users_index
    @users = User.order_created_at
  end
end
