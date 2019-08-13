class RemoveCountryFromSpaceShips < ActiveRecord::Migration[5.2]
  def change
    remove_column :spaceships, :country
  end
end
