class HomesController < ApplicationController
  def index
    if log_in?
      @posts = Post.order_created_at
      @notifications = @current_user.notifications.limit(7)
    end
  end

end
