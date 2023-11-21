class WinesController < ApplicationController
  before_action :set_wine, only: [:show]

  def index
    @wines = Wine.all
  end

  def show

  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    @wine.user = current_user
    if @wine.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def wine_params
    params.require(:wine).permit(:name, :region, :domain, :description, :year, :price,
                                 :stock_quantity, :category, :grape_variety, :alcohol_level, :photo)
  end
end
