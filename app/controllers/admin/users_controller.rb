class Admin::UsersController < Admin::BaseController
  before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :update, :destroy]
  before_action :load_support, only: [:index, :show]
  before_action :load_decentralizations, only: [:index]

  def index;  end

  def show
    UpdateNotificationService.new(params).perform if params[:notification_id]
    UpdateReportService.new(params).perform if params[:report_id]
  end

  def destroy;  end

  def update
    if @user.update user_params
      flash[:success] = "Success"
      redirect_to admin_users_path
    else
      flash[:danger] = "Fail"
      redirect_to admin_users_path
    end
  end

  def following
    render "show_follow"
  end

  def followers
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :user_type, :avatar, :status
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def load_support
    @support = UserSupport.new
  end

end
