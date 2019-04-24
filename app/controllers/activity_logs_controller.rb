class ActivityLogsController < ApplicationController
  before_action :activitylogs, only: [:index]
  before_action :new_notifications_count, :notifications_limit, :activitylogs, only: [:index]

  def index;  end

  private
  def activitylogs
    @activity_logs = Notification.check_target_id(current_user).check_status.order_by_created.page(params[:page]).per(10)
  end
end
