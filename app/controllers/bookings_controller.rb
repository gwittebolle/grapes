class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :wine_id)
  end

end
