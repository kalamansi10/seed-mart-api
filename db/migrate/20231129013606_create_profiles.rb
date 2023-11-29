class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :gender
      t.date :birthday
      t.text :adresses, array: true, default: []
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
