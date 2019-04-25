class HomesController < ApplicationController
  def index
    @posts = Post.all.order_created_at
    @search_posts = Post.search(params[:search_post])
    @searchs = User.search(params[:search])
    @posts_types = Post.search(params[:post_type_id]) if params[:post_type_id]
  end

end
