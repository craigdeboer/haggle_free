class BidsController < ApplicationController

	before_action :find_listing, only: [:new, :create]
	before_action :find_bid, only: [:edit, :update, :destroy]
	before_action :require_login
	before_action :bid_owner, only: :edit
	

	def index
		@bids = current_user.bids.includes(:listing).all
	end

	def new
		@bid = @listing.bids.new
		@bid.price = params[:price] if params[:price]
	end

	def create
		@bid = Bid.new(bid_params)
		if @bid.save
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
		redirect_to bids_path
	end

	def destroy
		@bid.destroy
		flash[:success] = "Bid successfully deleted."
		redirect_to bids_path
	end

private

	def bid_params
		params.require(:bid).permit(:price, :price_string, :listing_id).merge(user_id: current_user.id)
	end

	def find_listing
		@listing = Listing.find(params[:listing_id])
	end

	def find_bid
		@bid = Bid.find(params[:id])
	end

	def require_login
		if !logged_in?
			flash[:notice] = "You must be logged in to view the requested page."
			redirect_to login_path
		end
	end

	def bid_owner
		if @bid.user != current_user
			flash[:notice] = "You may not edit another user's bid."
			redirect_to root_path
		end
	end

end
