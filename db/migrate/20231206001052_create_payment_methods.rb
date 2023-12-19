class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.string :payment_type, null: false
      t.string :card_number, null: false
      t.string :expiry_date, null: false
      t.boolean :is_main, default: false, null: false

      t.timestamps
    end
  end
end
