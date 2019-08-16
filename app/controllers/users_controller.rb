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
    @user = User.find(params[:id])
    authorize @user
    @user.update(user_params)
    if @user.save
      redirect_to user_dashboard_account_info_path(@user)
    else
      render :edit
    end
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :species, :email, :payment_info, :image)
  end
end
