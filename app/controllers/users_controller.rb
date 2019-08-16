class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :mybookings, :addareview, :myshipsbookings, :myships]

  def show
    authorize @user
  end

  def edit
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
    @review_message = params[:message]
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :species, :email, :payment_info, :image)
  end
end
