class AddDefaultValueToShowReserve < ActiveRecord::Migration
  def change
  	change_column :auctions, :show_reserve, :boolean, default: false
  end
end
