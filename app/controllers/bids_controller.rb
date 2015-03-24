class BidsController < ApplicationController

	def index
		@bids = current_user.bids.includes(:listing).all
	end

	def new
		@listing = Listing.find(params[:listing_id])
		if !existing_bid(@listing) 
			@bid = @listing.bids.new
			@bid.price = params[:price] if params[:price]
		else
			flash[:error] = "You have already bid on this item. Please cancel your other bid before bidding again."
			redirect_to @listing
		end
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@bid = @listing.bids.new(bid_params)
		@bid.user_id = current_user.id
		if check_bid(@listing, @bid)
			if before_listing_end(@listing) && @bid.save
				flash[:success] = "Your bid has been accepted! Good luck!"
				redirect_to @listing
			else
				flash[:error] = "Unforturnately, this auction has ended."
				redirect_to root_path
			end
		else
			flash[:error] = "Your bid must be greater than the reserve price."
			render 'new'
		end
	end

	private

		def bid_params
			params.require(:bid).permit(:price)
		end

		def existing_bid(listing)
			!listing.bids.find_by(user_id: current_user.id).nil?
		end

		def check_bid(listing, bid)
			if listing.sell_method == "Price"
				check = true
			elsif (bid.price >= listing.auction.reserve) || !listing.auction.show_reserve 
				check = true
			else
				check = false
			end
			check
		end

		def before_listing_end(listing)
			if listing.sell_method == "Auction"
				is_before = DateTime.now < (listing.auction.end_date.beginning_of_day + 21.hours)
			else 
				is_before = DateTime.now < ((listing.price_fade.created_at.beginning_of_day + 21.hours) + (listing.price_fade.price_interval * 7).days)
			end
			is_before
		end


end
