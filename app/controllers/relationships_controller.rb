class RelationshipsController < ApplicationController
  before_action :log_in?, only: [:create, :destroy]
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    CreateNotificationService.new(target_id: current_user.id, des_id: user.id, target_type: "Followed", des_type: " ", url: user.id).create_notification
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    CreateNotificationService.new(target_id: current_user.id, des_id: user.id, target_type: "UnFollowed", des_type: " ", url: user.id).create_notification
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
