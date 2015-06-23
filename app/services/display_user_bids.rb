class DisplayUserBids

	def initialize(user)
		@user = user
	end

	def bids
		@bids = @user.bids.where("expired = ?", false).includes(:listing)
	end

	def expired_bids
		@expired_bids = @user.bids.where("expired = ?", true)
	end

	def expired_listing_title(id)
		@expired_listing_title = ExpiredListing.find_by_original_listing_id(id).pluck(:title)
	end
end