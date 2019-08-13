class AddPriceToShips < ActiveRecord::Migration[5.2]
  def change
    add_column :spaceships, :price, :integer, default: 0
  end
end
