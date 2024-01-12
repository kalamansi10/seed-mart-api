class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_reference, null: false
      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.bigint :shipping_address_id, null: false
      t.bigint :payment_method_id, null: false
      t.integer :amount, null: false
      t.json :adjustments
      t.integer :total, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
