class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :load_support, only: [:index, :new, :update, :create, :edit]

  def show
      @comment = Comment.new
      @comments = @post.comments.hash_tree(limit_depth: 2)
      UpdateNotificationService.new(params).perform if params[:notification_id]
      UpdateReportService.new(params).perform if params[:report_id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t("text.success")
      redirect_to root_path
    else
      flash[:warning] = t("text.fails")
      render :new
    end
  end

  def edit;  end

  def update
    if @post.update post_params
      flash[:success] =  t("text.success")
      redirect_to root_path
    else
      flash[:warning] =  t("text.fails")
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t("text.success")
    else
      flash[:danger] = t("text.fails")
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :post_type_id, :status, :images
  end

  def find_post
    @post = Post.find_by id: params[:id]
  end

  def load_support
    @support = PostSupport.new
  end
end
