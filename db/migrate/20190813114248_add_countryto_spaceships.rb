class AddCountrytoSpaceships < ActiveRecord::Migration[5.2]
  def change
    add_reference :spaceships, :country, foreign_key: true
  end
end
