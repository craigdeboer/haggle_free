class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id, index: true
      t.integer :listing_id, index: true
      t.decimal :price, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
