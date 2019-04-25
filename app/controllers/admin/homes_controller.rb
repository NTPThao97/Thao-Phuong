class Admin::HomesController < Admin::BaseController
  before_action :load_support, only: [:index]
  def index
    @users = User.all
  end

  private
  def load_support
    @support = StatistionSupport.new
  end
end
