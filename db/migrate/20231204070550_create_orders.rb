class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.bigint :user_id, null: false
      t.bigint :reference_id, null: false
      t.text :ordered_items, array: true
      t.string :payment_method, null: false
      t.json :shipping_address, null: false
      t.json :charges, null: false
      t.integer :order_total, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
