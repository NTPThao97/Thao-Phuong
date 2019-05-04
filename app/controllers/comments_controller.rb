class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by id: params[:comment].delete(:parent_id)
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end
    if @comment.save
      CreateNotificationService.new(target_id: @comment.user_id, des_id: @comment.post.user_id, target_type: "Commented", des_type: "Post", url: @comment.post_id, report: "").create_notification
      respond_to do |format|
        format.html{redirect_to post_path(@comment.post_id)}
        format.js
      end
    end
  end

  def destroy
    @comment.descendants.each do |comment_des|
      comment_des.destroy
    end
    @comment.destroy
    redirect_to post_path(@comment.post_id)
  end

  private
  def comment_params
    params.require(:comment).permit :post_id, :user_id, :content
  end

  def set_comment
    @comment = Comment.find_by id: params[:id]
  end
end
