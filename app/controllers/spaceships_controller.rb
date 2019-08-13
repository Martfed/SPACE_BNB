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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
