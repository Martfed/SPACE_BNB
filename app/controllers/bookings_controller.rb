class BookingsController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def accept
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.confirmation_status = "accepted"
    if @booking.save
      redirect_to user_dashboard_my_spaceships_bookings_path(current_user)
    else
      raise
    end
  end

   def reject
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.confirmation_status = "rejected"
    if @booking.save
       params[:stay] ? (redirect_to user_dashboard_path(current_user)) : (redirect_to user_dashboard_my_spaceships_bookings_path(current_user))
    else
      raise
    end
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.user_id = params[:user_id]
    @booking.spaceship_id = params[:spaceship_id]
    @start_date_ok = @booking.start_date >= Date.today
    @end_date_ok = @booking.start_date <= @booking.end_date
    @bookings = @booking.spaceship.bookings
    @result = []
    if @start_date_ok == true && @end_date_ok == true
      @bookings.where.not(confirmation_status: "done").where.not(confirmation_status: "rejected").each do |booking|
        @result << (@booking.start_date..@booking.end_date).overlaps?(booking.start_date..booking.end_date)
      end
      if @result.include? true
        assign_message("A spaceship is already booked for that period!")
      else
        @booking.save
        assign_message("Your booking was confirmed!")
      end
    else
      assign_message("Please enter a valid date range")
    end
    redirect_to user_spaceship_path(@booking.user_id, @booking.spaceship_id, message: @message)
  end

  def destroy
  end

  private

  def assign_message(content)
    @message = content
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
