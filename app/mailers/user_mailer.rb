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

	def answer_received(user_email, question, answer, listing_title)
		@user_email = user_email
		@question = question
		@answer = answer
		@listing_title = listing_title
		mail(to: user_email, subject: "Seller has answered your question regarding #{listing_title}")
	end

	def bid_change(listing_owner_email, listing_title, price, bidder)
		@listing_title = listing_title
		@price = price
		@bidder = bidder
		mail(to: listing_owner_email, subject: "Bid change for listing: #{listing_title}")
	end

	def listing_expired(email, title, bids_summary)
		@email = email
		@title = title
		@bids_summary = bids_summary
		mail(to: email, subject: "Summary for ended listing: #{title}")
	end
end
