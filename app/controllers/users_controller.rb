class UsersController < ApplicationController
  before_action :set_user_type, only: [ :create, :update]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :new_notifications_count, only: [:index, :show, :edit]

  def index
    if log_in?
      @users = User.all
      @user = @current_user
    else
      redirect_to root_path
    end
  end

  def show;  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Well come " + @user.name + " to your Blog"
      log_in @user
      redirect_to user_url(@user)
    else
      redirect_to sign_up_path
    end
  end

  def edit;  end

  def update
    @user.update user_params
    redirect_to user_path(@user)
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :user_type, :avatar
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def set_user_type
    params[:user_type] ||= "1"
  end

end
