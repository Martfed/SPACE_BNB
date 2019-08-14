class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def mybookings
    @bookings = Booking.where(user_id: params[:user_id])
  end

  def myships
    @user = User.find(params[:user_id])
    @ships = @user.spaceships
  end
end
