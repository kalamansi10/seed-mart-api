class CreateCartedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :carted_items do |t|
      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.integer :amount, null: false
      t.boolean :is_for_checkout, default: false, null: false

      t.timestamps
    end
  end
end
