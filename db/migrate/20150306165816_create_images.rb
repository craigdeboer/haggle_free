class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.integer :listing_id, index: true
    	t.boolean :main_image
      t.timestamps null: false
    end
  end
end
