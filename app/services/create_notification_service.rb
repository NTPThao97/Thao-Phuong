class CreateNotificationService
  attr_accessor :params

  def initialize params
    @target_id = params[:target_id]
    @des_id = params[:des_id]
    @target_type = params[:target_type]
    @des_type = params[:des_type]
    @url = params[:url]
  end

  def create_notification
    Notification.create! target_id: @target_id,
                                    des_id: @des_id,
                                    target_type: @target_type,
                                    des_type: @des_type,
                                    url: @url
    # create noti
    # return true / false
  end

  # private
  # def noti_params
  #   byebug
  #   params.require(:notification).permit :target_id, :des_id, :target_type, :des_type
  # end
end
