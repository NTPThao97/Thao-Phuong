class HomesController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  before_action :load_support, only: :index
  def index
    if log_in?
      @posts = @support.search_post(params[:q]).result.order_created_at.includes(:post_type, :user)
      flash[:warning] = "Not Found" if @posts.size == 0
    else
      @post_publics = @support.search_post(params[:q]).result.includes(:post_type, :user).where(status: :public).order_created_at.page(params[:page]).per 5
    end
  end
  private
  def load_support
    @support = PostSupport.new
  end
end
