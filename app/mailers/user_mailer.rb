class UserMailer < ApplicationMailer

	default from: "support@hagglefree.com"

	def bid_received(user, listing, bid, bidder)
		@user = user
		@listing = listing
		@bid = bid
		@bidder = bidder
		sleep 10
		mail(to: user.email, subject: "Bid Received")
	end

end
