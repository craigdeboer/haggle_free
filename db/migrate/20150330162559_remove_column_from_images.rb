class RemoveColumnFromImages < ActiveRecord::Migration
  def change
  	remove_column :images, :main_image
  end
end
