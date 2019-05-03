class Admin::PostsController < Admin::BaseController
  before_action :find_post, only: [:show, :destroy]
  before_action :load_support, only: [:index]
  def index
    @posts = Post.order_created_at
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Posts Management",
          page_size: 'A4',
          template: "admin/posts/show.html.erb",
          layout: "pdf.html.erb",
          orientation: "Landscape",
          encoding: 'UTF-8',
          lowquality: true,
          zoom: 1,
          dpi: 75
      end
    end
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
