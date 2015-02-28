class ChangeColumnNameTypeInListings < ActiveRecord::Migration
  def change
  	rename_column :listings, :type, :sell_method
  end
end
