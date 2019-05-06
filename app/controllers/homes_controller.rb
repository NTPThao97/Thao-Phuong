class HomesController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  def index
      @q = Post.ransack(params[:q])
    if log_in?
      @posts_search = @q.result.check_status_public.includes(:post_type, :user).page(params[:page]).per(5)
      flash[:warning] = t("text.not_found") if @posts_search.size == 0
      @posts = current_user.posts
    else
      @post_publics = @q.result.includes(:post_type, :user).status_public.order_created_at.page(params[:page]).per(10)
    end
    @users = User.search_user(params[:search]).order_created_at.page(params[:page]).per(5)
  end
end
