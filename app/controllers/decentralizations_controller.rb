class DecentralizationsController < ApplicationController
  before_action :find_decentralization, only: [:update, :destroy]
  def index;  end

  def new
    @decentralization = Decentralization.new
  end

  def create
    @decentralization = Decentralization.build decentralization_params
    @decentralization.save
    redirect_to decentralizations_path
  end

  def edit
  end

  def update
    @decentralization.update active: params[:active]
    respond_to do |format|
        format.html {redirect_to users_path}
        format.js
      end
    # @decenralization.update decentralization_params
    # redirect_to decenralizations_path
  end

  def destroy
    @decentralization.destroy
    redirect_to decentralizations_path
  end

  private

  def decentralization_params
    params.require(:decentralizations).permit :name, :describe, :number_account, :active
  end

  def find_decentralization
    @decentralization = Decentralization.find(params[:id]) if params[:id]
  end

end
