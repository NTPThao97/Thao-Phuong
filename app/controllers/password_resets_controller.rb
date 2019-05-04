class PasswordResetsController < ApplicationController
  before_action :get_user, :check_expiration, :valid_user, only: [:edit, :update]
  skip_before_action :new_notifications_count, :notifications_limit

  def new;  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_digest
      flash[:info] = t("text.sent_email")
      redirect_to root_url
    else
      flash.now[:danger] = t("text.not_found_email")
      render :new
    end
  end

  def edit;  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("text.error"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t("text.pass_reset")
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t("text.pass_reset_ex")
      redirect_to new_password_reset_url
    end
  end
end
