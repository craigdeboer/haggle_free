class ChangeColumnNameInListings < ActiveRecord::Migration
  def change
  	rename_column :listings, :subcategory_id, :sub_category_id
  end
end
