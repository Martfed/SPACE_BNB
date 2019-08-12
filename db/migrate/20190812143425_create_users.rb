class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :species
      t.string :email
      t.string :payment_info

      t.timestamps
    end
  end
end
