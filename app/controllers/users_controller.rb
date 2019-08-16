class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :mybookings, :addareview, :myshipsbookings, :myships]

  def show
    authorize @user
  end

  def edit
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
    authorize @user
    @spaceships = @user.spaceships
  end

  def myshipsbookings
    authorize @user
    @spaceships = @user.spaceships
  end

  def addareview
    authorize @user
    @spaceships = @user.spaceships
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
