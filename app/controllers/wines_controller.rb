class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update]

  def index
    @wines = Wine.order(created_at: :desc)
    .left_outer_joins(:bookings)
    .group('wines.id')
    .having('COUNT(bookings.id) = 0 OR COUNT(CASE WHEN bookings.status IN (?, ?) THEN 1 ELSE NULL END) = 0', 1, 3)
    user_signed_in? ? @users = User.joins(:wines).distinct.where.not(id: current_user.id) : @users = User.joins(:wines).distinct
    @booking = Booking.new
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "pages/info_window", locals: {user: user}),
        marker_html: render_to_string(partial: "shared/marker", locals: {user: user})
      }
    end

    if user_signed_in?
    # Ajouter le marqueur pour current_user
    @markers << {
      lat: current_user.latitude,
      lng: current_user.longitude,
      info_window_html: render_to_string(partial: "pages/info_home_window", locals: {user: current_user}),
      marker_html: render_to_string(partial: "shared/home_marker")
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
