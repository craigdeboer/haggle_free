class CreatePriceFades < ActiveRecord::Migration
  def change
    create_table :price_fades do |t|
      t.decimal :start_price, precision: 7, scale: 2
      t.decimal :end_price, precision: 7, scale: 2
      t.datetime :end_date
      t.integer :listing_id, index: true

      t.timestamps null: false
    end
  end
end
