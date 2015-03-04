class ChangeColumnNamesInPriceFades < ActiveRecord::Migration
  def change
  	remove_column :price_fades, :end_date
  	add_column :price_fades, :price_interval, :integer
  	rename_column :price_fades, :end_price, :price_decrement
  end
end
