class ExpiredListingsController < ApplicationController

	skip_before_action :require_login, only: [:index, :subcategory] 

	def index
		@expired_listings = ExpiredListing.all
	end

	def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
		@expired_listings = @subcategory.expired_listings.all
		render 'index'
	end

  def user
    @expired_listings = current_user.expired_listings.all
  end

  # This method will change the boolean "sold" attribute to true if the current user is the listing owner which should
  # always be the case because the "mark as sold" button should only be displayed to the listing owner.
	def mark_as_sold
		@expired_listing = ExpiredListing.find(params[:id])
		if !expired_listing_owner?
			flash[:notice] = "You may not edit another user's listing."
			redirect_to root_path
    else
      @expired_listing.update_column(:sold, true)
      redirect_to user_listings_path
    end
	end

private

	def expired_listing_owner?
		@expired_listing.user == current_user
	end

end
