class HomesController < ApplicationController
  def index
    @posts = Post.order_created_at
    @user = @current_user if log_in?
  end
end
