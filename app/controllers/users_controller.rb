class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def mybookings
    @bookings = Booking.where(user_id: params[:user_id])
  end

  def myships
    @user = User.find(params[:user_id])
    @spaceships = @user.spaceships
  end

  def myshipsbookings
    @user = User.find(params[:user_id])
    @spaceships = @user.spaceships
  end
end
