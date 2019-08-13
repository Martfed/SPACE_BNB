class SpaceshipsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @spaceships = Spaceship.all
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
  end

  def destroy
  end

  private

  def spaceship_params
    params.require(:spaceship).permit(:name, :description, :address, :country_id, :city, :capacity)
  end
end
