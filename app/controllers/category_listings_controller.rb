class CategoryListingsController < ApplicationController

	include SharedFilters
	skip_before_action :require_login

	def index
    @category = Category.find(params[:category_id])
		@listings = Listing.category_listings(@category).page(params[:page]).per_page(10)
	end

end
