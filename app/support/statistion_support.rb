class StatistionSupport
  def post_day
    @post_days = Post.where("created_at >= ?", 1.day.ago.to_datetime)
  end
  def user_day
    @user_days = User.where("created_at >= ?", 1.day.ago.to_datetime)
  end
  def report_day
    @report_days = Report.where("created_at >= ?", 1.day.ago.to_datetime)
  end
  def post_month
    @post_months = Post.group("DATE_FORMAT(created_at,'%b-%x-%y')").count
  end
  def user_month
    @user_months = User.group("DATE_FORMAT(created_at,'%b-%x-%y')").count
  end
  def post_table
    @posts = PostType.select("post_types.name, count(posts.id) as count").joins("inner join posts on posts.post_type_id = post_types.id ").group("post_types.name")
  end
end
