module NotificationsHelper
  def new_notifications_count
    if log_in?
      @new_notifications_count = @current_user.notifications.where("target_id != #{@current_user.id}").order_by_created
    end
  end
end

