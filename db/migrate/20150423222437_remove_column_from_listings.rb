class RemoveColumnFromListings < ActiveRecord::Migration
  def change
  	remove_column :listings, :post_date
  end
end
