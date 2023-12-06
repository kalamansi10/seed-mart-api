class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table(:orders, id: false) do |t|
      t.bigint :order_reference, null: false

      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.bigint :shipping_address_id, null: false
      t.bigint :payment_method_id, null: false

      t.integer :amount, null: false
      t.json :adjustments, null: false
      t.integer :total, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_index :orders, :order_reference
  end
end
