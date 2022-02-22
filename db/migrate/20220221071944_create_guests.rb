class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.jsonb :phone, default: []

      t.timestamps
    end

    add_index :guests, :email, unique: true
  end
end
