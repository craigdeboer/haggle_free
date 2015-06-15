class UserListingsController < ApplicationController

	def index
		session[:user_listings] = true
		@listings = Listing.user_listings(current_user).page(params[:page]).per_page(10) 
	end

end