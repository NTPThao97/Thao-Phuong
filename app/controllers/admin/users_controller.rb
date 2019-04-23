class Admin::UsersController < Admin::BaseController
  before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :destroy]
  before_action :load_support, only: [:index, :show]

  def index
    if log_in?
      @users = User.all
      @user = @current_user
      @posts = Post.order_created_at
    else
      redirect_to root_path
    end
  end

  def show
    @users = @user.following
    @followers = @user.followers
    @report = Report.new
    @posts = @user.posts.order_created_at.page(params[:page]).per(2)
    UpdateNotificationService.new(params).perform if params[:notification_id]
    @report = Report.find_by(id: params[:report_id])
    @report.update opened_at: Time.current if params[:report_id]
  end

  def destroy;  end

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
