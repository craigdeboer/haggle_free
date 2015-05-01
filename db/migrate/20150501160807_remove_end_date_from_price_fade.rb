class RemoveEndDateFromPriceFade < ActiveRecord::Migration
  def change
  	remove_column :price_fades, :end_date
  end
end
