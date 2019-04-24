class NotificationsController < ApplicationController
  before_action :new_notifications_count, :notifications_limit, :notifications, only: [:index]

  def index;  end

  def destroy
    find_notification
    @notification.update status: false
    redirect_to notifications_path
  end

  private
  def find_notification
    @notification = Notification.find_by(id: params[:id])
  end
end
