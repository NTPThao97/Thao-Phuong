class HomesController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  def index
      @q = Post.ransack(params[:q])
    if log_in?
      @posts_search_current_users = @q.result.check_current_user(current_user)
        .includes(:post_type, :user).page(params[:page]).per(5)
      @posts_search_relations = @q.result.check_status.order_status
        .where('posts.user_id IN (?)', current_user.following.pluck(:id).join(','))
        .includes(:post_type, :user).page(params[:page]).per(5)
      flash[:warning] = t("text.not_found") if @posts_search_current_users.size == 0 && @posts_search_relations.size == 0
      @posts_homes = current_user.posts_home.page(params[:page]).per(5)
    else
      @post_publics = @q.result.includes(:post_type, :user).status_public.order_created_at.page(params[:page]).per(10)
    end
    @users = User.search_user(params[:search]).order_created_at.page(params[:page]).per(5)
  end
end
