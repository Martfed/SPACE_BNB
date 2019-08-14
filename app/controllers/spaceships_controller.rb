class SpaceshipsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_spaceship, only: [:show, :edit, :update]

  def index
    @spaceships = Spaceship.geocoded #returns flats with coordinates

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
  end

  def new
    @spaceship = Spaceship.new
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    @spaceship.user = User.find(params[:user_id])
    @spaceship.save
    redirect_to user_spaceships_path
  end

  def edit
  end

  def update
    @spaceship.update(spaceship_params)
    if @spaceship.save
      redirect_to user_spaceships_path
    else
      raise
    end
  end

  def destroy
  end

  private

  def set_spaceship
    @spaceship = Spaceship.find(params[:id])
  end

  def spaceship_params
    params.require(:spaceship).permit(:name, :description, :address, :country_id, :city, :capacity, :image, :price)
  end
end
