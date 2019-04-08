class HomesController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, only: [:index]
  def index
    if log_in?
      @posts = Post.order_created_at
    end
  end

end
