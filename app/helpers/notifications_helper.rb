module NotificationsHelper
  def new_notifications_count
    if log_in?
      if admin_user
        @new_notifications_count = Notification.where("opened_at IS NULL").order_by_created
      else
        @new_notifications_count = @current_user.notifications.where("target_id != #{@current_user.id}").where("opened_at IS NULL").order_by_created
      end
    end
  end
  def notifications_limit
    if log_in?
      if admin_user
        @notifications_limit = Notification.order_by_created.limit(8)
      else
        @notifications_limit = @current_user.notifications.where("target_id != #{@current_user.id}").order_by_created.limit(8)
      end
    end
  end

  def notifications
    if log_in?
      if admin_user
        @notifications = Notification.where("target_type != 'Reported'").where("status = true").order_by_created
      else
        @notifications = @current_user.notifications.where("target_type != 'Reported'").where("target_id != #{@current_user.id}").where("status = true").order_by_created
      end
    end
  end
end
