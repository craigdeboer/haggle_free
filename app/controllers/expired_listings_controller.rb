class ExpiredListingsController < ApplicationController

	skip_before_action :require_login, only: [:index, :subcategory] 

	def index
		@expired_listings = ExpiredListing.all
	end

	def subcategory
		@expired_listings = ExpiredListing.where("sub_category_id = ?", params[:sub_category_id])
		render 'index'
	end

	def mark_as_sold
		@expired_listing = ExpiredListing.find(params[:id])
		expired_listing_owner
		@expired_listing.update_column(:sold, true)
		redirect_to user_listings_path
	end

private

	def expired_listing_owner
		if @expired_listing.user != current_user
			flash[:notice] = "You may not edit another user's listing."
			redirect_to root_path
		end
	end

end