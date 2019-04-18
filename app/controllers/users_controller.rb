class UsersController < ApplicationController
  before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :new_notifications_count, :notifications_limit, :reports, :load_support, :load_decentralizations, only: [:index, :show, :edit]

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

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account or click here."
      @decentralization = Decentralization.find_by(id: @user.user_type)
      @decentralization.update number_account: @decentralization.number_account.to_i + 1
      redirect_to root_url
    else
      redirect_to sign_up_path
    end
  end

  def edit; end

  def update
    @user.update user_params
    flash[:success] = "Success"
    redirect_to users_path
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
