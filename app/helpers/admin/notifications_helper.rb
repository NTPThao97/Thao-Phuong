module Admin::NotificationsHelper
  def new_notifications_count
    if log_in?
      @new_notifications_count = Notification.where("target_type != 'Reported'").where("des_id = #{current_admin.id}").where("opened_at IS NULL").order_by_created
    end
  end
  def notifications_limit
    if log_in?
      @notifications_limit = Notification.where("target_type != 'Reported'").where("des_id = #{current_admin.id}").order_by_created.limit(8)
    end
  end

  def notifications
    if log_in?
      @notifications = Notification.where("target_type != 'Reported'").where("des_id = #{current_admin.id}").where("status = true").order_by_created.page(params[:page]).per(10)
    end
  end
end
