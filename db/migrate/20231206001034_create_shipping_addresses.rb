class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.bigint :user_id, null: false
      t.string :street_address, null: false
      t.string :barangay, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :region, null: false
      t.boolean :is_main, default: false, null: false

      t.timestamps
    end
  end
end
