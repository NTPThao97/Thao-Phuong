class Admin::HomesController < Admin::BaseController
  before_action :load_support, only: [:index]
  def index
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Statistion Management",
          page_size: 'A4',
          template: "admin/homes/index.html.erb",
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
    @support = StatistionSupport.new
  end
end
