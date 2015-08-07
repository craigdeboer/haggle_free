class BidsController < ApplicationController

	before_action :set_listing, only: [:index, :new, :create]
	before_action :set_bid, only: [:edit, :update, :destroy]
	before_action :bid_owner, only: :edit
	

	def index
    @bid_manager = BidManager.new(params)
	end

	def new
    @bid_manager = BidManager.new(params)
	end

	def create
    @bid_manager = BidManager.new(params)
    @bid = Bid.new(bid_params)
    if @bid.save 
			UserMailer.bid_received(@bid_manager.listing_owner, @bid.listing, @bid, current_user).deliver_later
			flash[:success] = "Your bid has been accepted! Good luck!"
			redirect_to @listing
		else
			if @bid.errors.include?(:ended)
				flash[:error] = "Your bid was not accepted, the auction has ended."
				redirect_to sub_category_listings_path(sub_category_id: @bid_manager.listing_sub_category)
			else
				render 'new'
			end
		end
	end

	def edit
	end

	def update
    @bid_manager = BidManager.new(params[:bid])
		@bid.update_attributes(price_string: bid_params[:price_string])
		UserMailer.bid_change(@bid_manager.listing_user_email, @bid_manager.listing_title, @bid.price.to_f, current_user.user_name).deliver_later
		redirect_to user_bids_path
	end

	def destroy
		@bid.destroy
		if @bid.listing.sell_method == "Price" && @bid.listing.bids_count == 1
			@bid.listing.price_fade.bid_deleted
		end
		flash[:success] = "Bid successfully deleted."
		redirect_to user_bids_path
	end

private

	def bid_params
		params.require(:bid).permit(:price, :price_string).merge(user_id: current_user.id, listing_id: params[:listing_id])
	end

	def set_listing
		@listing = Listing.find(params[:listing_id])
	end

	def set_bid
		@bid = Bid.find(params[:id])
	end

	def bid_owner
		if @bid.user != current_user
			flash[:notice] = "You may not edit another user's bid."
			redirect_to root_path
		end
	end

end
