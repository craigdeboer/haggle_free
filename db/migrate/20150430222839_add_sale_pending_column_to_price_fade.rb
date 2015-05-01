class AddSalePendingColumnToPriceFade < ActiveRecord::Migration
  def change
  	add_column :price_fades, :sale_pending, :boolean, default: false
  end
end
