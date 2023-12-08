class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.string :payment_type
      t.string :card_number
      t.string :expiry_date
      t.timestamps
    end
  end
end
