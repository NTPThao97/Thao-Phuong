class HomesController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit
  def index
    if log_in?
      load_support
    else
      @post_publics = Post.where(status: "public").order_created_at
    end
  end
  private
  def load_support
    @support = PostSupport.new
  end
end
