class BookingsController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = User.find(params[:user_id])
    @booking.spaceship = Spaceship.find(params[:spaceship_id])
    @booking.save
    redirect_to user_spaceships_path
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
