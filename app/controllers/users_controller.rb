class UsersController < ApplicationController
  before_action :set_user_type, only: [:create, :edit, :update]
  def index
    @users = User.all
  end
  def show
    find_user
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Well come " + @user.name + " to your Blog"
      redirect_to @user
    else
      redirect_to signup_path
    end
  end
  def edit;  end
  def update
    @user = User.update user_params
    redirect_to root_path
  end
  def destroy
    @user.destroy
    redirect_to root_path
  end
  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :user_type
  end
  def find_user
    @user = User.find_by id: params[:id]
  end
  def set_user_type
       params[:user_type] ||= 1
     end
end
