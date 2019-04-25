class AccountActivationsController < ApplicationController
  skip_before_action :check_log_in, :new_notifications_count, :notifications_limit, only: [:edit]
  def edit
    byebug
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
