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
    if Review.exists?(@review.id)
      assign_message("A review for this booking was already found. You can only do one review per booking.")
      redirect_to user_dashboard_add_review_path(current_user, message: @review_message)
    else
      @review.save
      redirect_to user_spaceship_path(params[:user_id], params[:spaceship_id])
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def assign_message(content)
    @review_message = content
  end

  def review_params
    params.require(:review).permit(:rating, :content, :id)
  end
end
