class ExpiredListing < ActiveRecord::Base

	belongs_to :user

	def self.convert(listing, bid_count, highest_bid)
		@expired_listing = ExpiredListing.new(original_listing_id: listing.id, title: listing.title, number_of_bids: bid_count, highest_bid: highest_bid, end_date: listing.end_date)
		@expired_listing.save
	end

	def self.purge
		@expired_listings = ExpiredListing.where("created_at > ?", 14.days.ago)
		@expired_listings.each do |expired_listing|
			Bid.purge(expired_listing.original_listing_id)
			expired_listing.destroy
		end
	end
end
