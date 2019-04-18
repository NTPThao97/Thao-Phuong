class HomesController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, :reports, only: [:index]
  def index
    @posts = Post.all.order_created_at.page(params[:page]).per(2)
  end

end
