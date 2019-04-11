class HomesController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, :reports, :post_private, only: [:index]
  def index
  end

end
