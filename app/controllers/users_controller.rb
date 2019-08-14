class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def myspaceships
    @bookings = Booking.where(user_id: params[:user_id])
  end
end
