class BidsController < ApplicationController

	def index
		@bids = current_user.bids.includes(:listing).all
	end

	def new
		@listing = Listing.find(params[:listing_id])
		@bid = @listing.bids.new
		@bid.price = params[:price] if params[:price]
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@bid = @listing.bids.new(bid_params)
		@bid.user_id = current_user.id
		if @bid.save
			flash[:success] = "Your bid has been accepted! Good luck!"
			redirect_to @listing
		else
			render 'new'
		end
	end

	def destroy
		@bid = Bid.find(params[:id])
		@bid.destroy
		flash[:success] = "Bid successfully deleted."
		redirect_to bids_path
	end

private

	def bid_params
		params.require(:bid).permit(:price)
	end

end
