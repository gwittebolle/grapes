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

  def validate
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    @booking.save
    render_notifications
  end

  def deliver
    @booking = Booking.find(params[:id])
    @booking.status = "delivered"
    @booking.save
    render_notifications
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.status = "rejected"
    @booking.save
    render_notifications
  end


  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to profile_path, status: :see_other
  end

  private

  def set_wine
    @wine = Wine.find(params[:wine_id])
  end

  def render_notifications
    respond_to do |format|
      format.js { render partial: "notifications/notifications_partial", locals: { wines: current_user.wines } }
    end
  end
end
