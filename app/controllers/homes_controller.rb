class HomesController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, only: [:index]
  def index
    @posts = Post.all.order_created_at.page(params[:page]).per(2)
    @search_posts = Post.search(params[:search_post])
    @searchs = User.search(params[:search])
    @posts_types = Post.find_by(post_type_id: params[:post_type_id]) if params[:post_type_id]
  end

end
