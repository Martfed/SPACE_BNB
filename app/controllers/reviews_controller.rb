class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @booking = Booking.where(user_id: params[:user_id], spaceship_id: params[:spaceship_id])
    @review.booking_id = @booking[0].id
    @review.save
    redirect_to user_spaceship_path(params[:user_id], params[:spaceship_id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :id)
  end
end
