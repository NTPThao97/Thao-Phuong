module NotificationsHelper
  def new_notifications_count
    @new_notifications_count = Notification.check_des_id(current_user).check_target_id(current_user).check_opened_at.order_by_created
  end
  def notifications_limit
    @notifications_limit = Notification.check_des_id(current_user).check_target_id(current_user).order_by_created.limit(8)
  end

  def notifications
    @notifications = Notification.check_des_id(current_user).check_target_id(current_user).check_status.order_by_created.page(params[:page]).per(10)
  end
end
