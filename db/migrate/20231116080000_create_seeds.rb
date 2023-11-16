class CreateSeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :seeds do |t|
      t.string :name
      t.string :plant_type
      t.string :growing_season
      t.string :seed_varieties
      t.string :planting_location
      t.string :special_attributes
      t.string :planting_method
      t.string :package_size
      t.integer :price
      t.text :tags
      t.text :image_links, array: true, default: ["https://placehold.co/600x400", "https://placehold.co/400x600", "https://placehold.co/400x400", "https://placehold.co/600x600"]

      t.timestamps
    end
  end
end
