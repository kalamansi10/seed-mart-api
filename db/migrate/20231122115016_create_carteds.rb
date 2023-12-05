class CreateCarteds < ActiveRecord::Migration[7.1]
  def change
    create_table :carteds do |t|
      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
