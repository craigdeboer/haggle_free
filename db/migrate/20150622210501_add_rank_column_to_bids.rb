class AddRankColumnToBids < ActiveRecord::Migration
  def change
    add_column :bids, :rank, :integer
  end
end
