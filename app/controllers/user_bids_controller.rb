class UserBidsController < ApplicationController

	def index
		@user_bids = UserBids.new(current_user)
	end

end