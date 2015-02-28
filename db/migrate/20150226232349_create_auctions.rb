class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.decimal :reserve, precision: 7, scale: 2
      t.boolean :show_reserve
      t.datetime :end_date
      t.integer :listing_id, index: true

      t.timestamps null: false
    end
  end
end
