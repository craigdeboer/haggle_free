class UserMailer < ApplicationMailer

	default from: "support@hagglefree.com"

	def bid_received(user, listing, bid, bidder)
		@user = user
		@listing = listing
		@bid = bid
		@bidder = bidder
		mail(to: user.email, subject: "Bid Received")
	end

	def question_received(user, question, listing)
		@user = user
		@question = question
		@listing = listing
		mail(to: user.email, subject: "Question about #{@listing.title}")
	end

end
