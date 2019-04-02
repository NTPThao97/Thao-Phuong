class HomesController < ApplicationController
  def index
    @posts = Post.order_created_at
  end

end
