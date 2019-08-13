class SpaceshipsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_spaceship, only: [:show]

  def index
    @spaceships = Spaceship.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_spaceship
    @spaceship = Spaceship.find(params[:id])
  end
end
