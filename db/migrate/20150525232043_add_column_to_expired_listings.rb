class AddColumnToExpiredListings < ActiveRecord::Migration
  def change
  	add_column :expired_listings, :subcategory_id, :integer
  	add_index :expired_listings, :subcategory_id
  end
end
