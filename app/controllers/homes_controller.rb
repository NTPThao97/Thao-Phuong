class HomesController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, :reports, :notifications_opened_at, only: [:index]
  def index
    @posts = Post.all.order_created_at
  end

end
