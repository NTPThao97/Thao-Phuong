class DecentralizationsController < ApplicationController
  before_action :find_decenralization, only: [:edit, :update, :destroy]
  def index
    @decenralizations = Decentralization.all
  end

  def new
    @decenralization = Decentralization.new
  end

  def create
    @decenralization = Decentralization.build decentralization_params
    @decenralization.save
    redirect_to decenralizations_path
  end

  def edit
  end

  def update
    @decenralization.update decentralization_params
    redirect_to decenralizations_path
  end

  def destroy
    @decenralization.destroy
    redirect_to decenralizations_path
  end

  private

  def decentralization_params
    params.require(:decenralizations).permit :name, :describe, :number_acount, :active
  end

  def find_decenralization
    @decenralization = Decentralizations.find(params[:id]) if params[:id]
  end
end
