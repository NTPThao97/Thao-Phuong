module Admin::NotificationsHelper
  def new_notifications_count
    @new_notifications_count = Notification.admin_check_target_type.admin_check_des_id(current_admin).check_opened_at.order_by_created
  end
  def notifications_limit
    @notifications_limit = Notification.admin_check_target_type.admin_check_des_id(current_admin).order_by_created.limit(8)
  end

  def notifications
    @notifications = Notification.admin_check_target_type.admin_check_des_id(current_admin).admin_check_status.order_by_created.page(params[:page]).per(10)
  end
end
