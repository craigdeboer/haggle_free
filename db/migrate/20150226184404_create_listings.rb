class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :type
      t.date :post_date
      t.integer :subcategory_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
