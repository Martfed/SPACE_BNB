class UsersController < ApplicationController
  before_action :set_user, only: [:show, :mybookings]

  def show
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    authorize @user
  end

  def mybookings
    authorize @user
    @bookings = Booking.where(user_id: params[:user_id])
  end

  def myships
    @user = User.find(params[:user_id])
    authorize @user
    @spaceships = @user.spaceships
  end

  def myshipsbookings
    @user = User.find(params[:user_id])
    authorize @user
    @spaceships = @user.spaceships
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
