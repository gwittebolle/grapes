class BookingsController < ApplicationController
  before_action :set_wine, only: [:new, :create]
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    @booking.user = current_user
    @booking.wine = @wine
    if @booking.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:wine_id])
  end

end
