class HomesController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  def index
      @q = Post.order_created_at.ransack(params[:q])
    if log_in?
      @posts = @q.result.order_created_at.includes(:post_type, :user)
      flash[:warning] = "Not Found" if @posts.size == 0
    else
      @post_publics = @q.result.includes(:post_type, :user).where(status: :public).order_created_at.page(params[:page]).per 5
    end
  end
end
