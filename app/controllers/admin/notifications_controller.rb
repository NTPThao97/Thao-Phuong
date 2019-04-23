class Admin::NotificationsController < Admin::BaseController
  before_action :notifications, only: [:index]
  def index
  end

  def show
  end

  def update;  end

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
