class Admin::ActivityLogsController < Admin::BaseController
  before_action :activitylogs, only: [:index]
  def index;  end

  private
  def activitylogs
    @activity_logs = Notification.admin_check_des_id(current_admin).admin_check_status.order_by_created.page(params[:page]).per(10)
  end
end
