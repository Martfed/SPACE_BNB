class AddCoordinatesToSpaceships < ActiveRecord::Migration[5.2]
  def change
    add_column :spaceships, :latitude, :float
    add_column :spaceships, :longitude, :float
  end
end
