class Admin::PostsController < Admin::BaseController
  before_action :find_post, only: [:show, :destroy]
  before_action :load_support, only: [:index]
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.hash_tree(limit_depth: 2)
    UpdateNotificationService.new(params).perform if params[:notification_id]
    UpdateReportService.new(params).perform if params[:report_id]
  end

  def destroy
    if @post.destroy
      Notification.find_by(url: @post.id).destroy
      Report.find_by(url: @post.id).destroy
      flash[:success] = "Success!"
      redirect_to root_path
    end
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
  end

  def load_support
    @support = PostSupport.new
  end

end
