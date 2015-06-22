class UserBidsController < ApplicationController

	def index
		@user_bids = DisplayUserBids.new(current_user)
	end

end