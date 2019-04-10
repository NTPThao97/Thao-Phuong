module NotificationsHelper
  def new_notifications_count
    if log_in?
      @new_notifications_count = @current_user.notifications.where("target_id != #{@current_user.id}").where("opened_at IS NULL").order_by_created
    end
  end
  def notifications_limit
    if log_in?
      @notifications_limit = @current_user.notifications.where("target_id != #{@current_user.id}").order_by_created.limit(8)
    end
  end

  def notifications
    if log_in?
      @notifications = @current_user.notifications.where("target_id != #{@current_user.id}").where("status = true").order_by_created
    end
  end
end
