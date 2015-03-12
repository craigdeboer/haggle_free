class AddListingsCountToSubCategories < ActiveRecord::Migration
  def change
  	add_column :sub_categories, :listings_count, :integer, default: 0, null: false
  end
end
