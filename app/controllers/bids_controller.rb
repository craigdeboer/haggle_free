class BidsController < ApplicationController

	before_action :set_listing, only: [:index, :new, :create]
	before_action :set_bid, only: [:edit, :update, :destroy]
	before_action :bid_owner, only: :edit
	

	def index
		@bids = @listing.bids.all
	end

	def user
		@bids = current_user.bids.includes(:listing).all
		render 'index'
	end

	def new
		@bid = @listing.bids.new
		@bid.price = params[:price] if params[:price]
	end

	def create
		@bid = Bid.new(bid_params)
		if @bid.save
			listing_owner = User.find(@bid.listing.user_id)
			UserMailer.bid_received(listing_owner, @bid.listing, @bid, current_user).deliver_later
			flash[:success] = "Your bid has been accepted! Good luck!"
			redirect_to @listing
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@bid.update_attributes(price_string: bid_params[:price_string])
		UserMailer.bid_change(@bid.listing.user.email, @bid.listing.title, @bid.price.to_f, current_user.user_name).deliver_later
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
