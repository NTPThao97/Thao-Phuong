class SymbNotificationService
  attr_accessor :params

  def initialize params
    @comment = params[:comment]
  end

  def create_notification
    Notification.create! target_id: @comment.user_id,
                                    des_id: @comment.post.user_id,
                                    target_type: "Commented",
                                    des_type: "Post"
    # create noti
    # return true / false
  end

  # private
  # def noti_params
  #   byebug
  #   params.require(:notification).permit :target_id, :des_id, :target_type, :des_type
  # end
end
