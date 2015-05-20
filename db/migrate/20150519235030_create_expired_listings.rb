class CreateExpiredListings < ActiveRecord::Migration
  def change
    create_table :expired_listings do |t|
      t.integer :original_listing_id
      t.string :title
      t.integer :number_of_bids
      t.decimal :highest_bid, precision: 7, scale: 2
      t.datetime :end_date
      t.integer :user_id
      t.boolean :sold, default: false
      t.timestamps null: false
    end
  end
end
