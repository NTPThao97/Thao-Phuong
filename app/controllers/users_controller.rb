class UsersController < ApplicationController
  before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :load_support, only: [:show, :edit]
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    UpdateNotificationService.new(params).perform if params[:notification_id]
    UpdateReportService.new(params).perform if params[:report_id]
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("text.check_email")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t("text.success")
      redirect_to @user
    else
      render :edit
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
