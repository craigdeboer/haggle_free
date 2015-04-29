class AddColumnToPriceFade < ActiveRecord::Migration
  def change
  	add_column :price_fades, :end_date, :datetime
  end
end
