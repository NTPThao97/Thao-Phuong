class ActivityLogsController < ApplicationController
  before_action :activitylogs, only: [:index]

  def index;  end

  private
  def activitylogs
    @activity_logs = Notification.check_target_id_activity(current_user).order_by_created.page(params[:page]).per(10)
  end
end
