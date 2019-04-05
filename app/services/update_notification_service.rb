class UpdateNotificationService
attr_accessor :notification

  def initialize params
    @notification = Notification.find_by(id: params[:notification_id])
  end

  def perform
    notification.update! opened_at: Time.current
    true
  rescue StandardError
    false
  end

end
