class SpaceshipsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_spaceship, only: [:show, :edit, :update, :destroy]

  def index
    @spaceships = policy_scope(Spaceship).order(created_at: :desc)
    # @spaceships = Spaceship.geocoded #returns spaceships with coordinates

    @markers = @spaceships.map do |spaceship|
      {
        lat: spaceship.latitude,
        lng: spaceship.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { spaceship: spaceship }),
        image_url: helpers.asset_url("/images/map-marker.png")
      }
    end
  end

  def show
    authorize @spaceship
    @markers = [@spaceship].map do |spaceship|
      {
        lat: spaceship.latitude,
        lng: spaceship.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { spaceship: spaceship }),
        image_url: helpers.asset_url("/images/map-marker.png")
      }
    end
    @message = params[:message]
    @reviews = @spaceship.reviews.order(created_at: :desc)
  end

  def new
    @spaceship = Spaceship.new
    authorize @spaceship
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    authorize @spaceship
    @spaceship.user = User.find(params[:user_id])
    @spaceship.save
    redirect_to user_spaceship_path(current_user, @spaceship)
  end

  def edit
    authorize @spaceship
  end

  def update
    authorize @spaceship
    @spaceship.update(spaceship_params)
    if @spaceship.save
      redirect_to user_spaceship_path(current_user, @spaceship)
    else
      render :edit
    end
  end

  def destroy
    authorize @spaceship
    @spaceship.destroy
    redirect_to user_dashboard_my_spaceships_path(current_user)

  end

  private

  def set_spaceship
    @spaceship = Spaceship.find(params[:id])
  end

  def spaceship_params
    params.require(:spaceship).permit(:name, :description, :address, :country_id, :city, :capacity, :image, :price)
  end
end
