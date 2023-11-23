class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update]

  def index
    @wines = Wine.all
    user_signed_in? ? @users = User.joins(:wines).distinct.where.not(id: current_user.id) : @users = User.joins(:wines).distinct
    @booking = Booking.new
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "pages/info_window", locals: {user: user}),
        marker_html: render_to_string(partial: "shared/marker")
      }
    end
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

  def edit
  end

  def update
    @wine.update(wine_params)
    redirect_to profile_path
  end

  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy
    redirect_to profile_path, status: :see_other
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
