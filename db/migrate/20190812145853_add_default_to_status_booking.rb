class AddDefaultToStatusBooking < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :confirmation_status, :string, default: 'pending'
  end
end
