class UsersController < ApplicationController
  before_action :set_user, only: [:show, :mybookings]

  def show
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

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
