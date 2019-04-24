class Admin::DecentralizationsController < Admin::BaseController
  before_action :find_decentralization, only: [:update, :destroy]
  def index;  end

  def new
    @decentralization = Decentralization.new
  end

  def create
    @decentralization = Decentralization.build decentralization_params
    if @decentralization.save
      flash[:success] = "Success!"
      redirect_to admin_decentralizations_path
    else
      flash[:danger] = "Fails!"
      redirect_to admin_decentralizations_path
    end
  end

  def edit
  end

  def update
    @decentralization.update active: params[:active]
    respond_to do |format|
        format.html {redirect_to admin_users_path}
        format.js
      end
  end

  def destroy
    @decentralization.destroy
    redirect_to admin_decentralizations_path
  end

  private

  def decentralization_params
    params.require(:decentralizations).permit :name, :describe, :number_account, :active
  end

  def find_decentralization
    @decentralization = Decentralization.find(params[:id]) if params[:id]
  end

end
