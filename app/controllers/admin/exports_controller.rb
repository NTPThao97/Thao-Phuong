class Admin::ExportsController < Admin::BaseController
  before_action :load_support, :load_decentralizations, :set_support, only: [:index]
  def index
    @posts = Post.order_created_at
    respond_to do |format|
      format.pdf do
          render pdf: params[:name],
          page_size: 'A4',
          template: params[:link],
          layout: "pdf.html.erb",
          orientation: "Landscape",
          encoding: 'UTF-8',
          lowquality: true,
          zoom: 1,
          dpi: 75
      end
    end
  end
  private
  def load_support
    @support = UserSupport.new
  end
  def set_support
    @support_statis = StatistionSupport.new
  end
end
