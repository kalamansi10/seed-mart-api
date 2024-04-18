class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.bigint :order_id, null: false
      t.integer :rating, null: false
      t.text :comment
      t.timestamps
    end
  end
end
