class AddIndexToExpiredListings < ActiveRecord::Migration
  def change
  	add_index :expired_listings, :original_listing_id
  	add_index :expired_listings, :user_id
  end
end
