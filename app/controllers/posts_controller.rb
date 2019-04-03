class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :load_support, only: [:index, :new, :edit]

  def index
    @posts = Post.all
  end

  def show
    @user = @current_user if log_in?
    @comment = Comment.new
    @comments = @post.comments.hash_tree(limit_depth: 2)
    @notifications = @current_user.notifications.limit(7)
  end

  def new
    @post = Post.new
    @notifications = @current_user.dess.limit(7)
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
   @notifications = @current_user.notifications.limit(7)
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
    @post.destroy
    flash[:success] = "Success!"
    redirect_to root_path
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
