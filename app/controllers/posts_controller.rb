class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :load_support, only: [:index, :new, :edit]
  before_action :new_notifications_count, :notifications_limit, only: [:index, :show, :new, :edit]

  def index
    @posts = Post.all
    @report = Report.new
  end

  def show
      @user = @current_user if log_in?
      @comment = Comment.new
      @comments = @post.comments.hash_tree(limit_depth: 2)
      UpdateNotificationService.new(params).perform if params[:notification_id]
  end

  def new
    @post = Post.new
    @user = @current_user  if log_in?
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = "Post created success!"
      redirect_to root_path
    else
      flash[:warning] = "Fails"
      redirect_to root_path
    end
  end

  def edit
    @user = @current_user  if log_in?
  end

  def update
    if @post.update post_params
      flash[:success] = "Update is success!"
      redirect_to root_path
    else
      flash[:warning] = "Fails"
      redirect_to root_path
    end
  end

  def destroy
    if @post.destroy
      Comment.find_by(post_id: @post.id).destroy
      Notification.find_by(url: @post.id).destroy
      flash[:success] = "Success!"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :post_type_id
  end

  def find_post
    @post = Post.find_by id: params[:id]
  end

  def load_support
    @support = PostSupport.new
  end

end
