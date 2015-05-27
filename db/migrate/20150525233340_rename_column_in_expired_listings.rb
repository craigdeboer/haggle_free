class RenameColumnInExpiredListings < ActiveRecord::Migration
  def change
  	rename_column :expired_listings, :subcategory_id, :sub_category_id
  end
end
