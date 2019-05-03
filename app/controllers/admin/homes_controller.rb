class Admin::HomesController < Admin::BaseController
  before_action :set_support, only: [:index]
  def index
  end

  private
  def set_support
    @support_statis = StatistionSupport.new
  end
end
