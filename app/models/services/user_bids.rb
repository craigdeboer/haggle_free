class UserBids

	def initialize(user)
		@user = user
	end

	def bids
		@bids = user.bids.where("expired = ?", false)
	end

	def expired_bids
		@expired_bids = user.bids.where("expired = ?", true)
	end

end