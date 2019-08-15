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
    @booking.user_id = params[:user_id]
    @booking.spaceship_id = params[:spaceship_id]
    @start_date_ok = @booking.start_date >= Date.today
    @end_date_ok = @booking.start_date <= @booking.end_date
    @bookings = @booking.spaceship.bookings
    @result = []
    if @start_date_ok == true && @end_date_ok == true
      @bookings.where.not(confirmation_status: "done").where.not(confirmation_status: "rejected").each do |booking|
        @result << (@booking.start_date.between?(booking.start_date, booking.end_date) && @booking.end_date.between?(booking.start_date, booking.end_date))
      end
      if @result.include? true
        raise
      else
        @booking.save
      end
    else
      raise
    end
    redirect_to user_spaceships_path
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
