class ActivityLogsController < ApplicationController
  before_action :activitylogs, only: [:index]
  before_action :new_notifications_count, :notifications_limit, :activitylogs, only: [:index]

  def index;  end

  private
  def activitylogs
    if log_in?
      @activity_logs = Notification.where("target_id = #{current_user.id}").where("status = true").order_by_created.page(params[:page]).per(10)
    end
  end
end
