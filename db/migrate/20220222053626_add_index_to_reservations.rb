class AddIndexToReservations < ActiveRecord::Migration[6.1]
  def change
    add_index :reservations, :code, unique: true
  end
end
