class CreateBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :banners do |t|
      t.string :banner_name
      t.string :image_link
      t.string :banner_link
      t.boolean :is_active?, default: true

      t.timestamps
    end
  end
end
