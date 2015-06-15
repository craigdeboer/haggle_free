class CategoryListingsController < ApplicationController

	include SharedFilters
	skip_before_action :require_login
	before_action :clear_my_listings

	def index
		@listings = Listing.category_listings(category).page(params[:page]).per_page(10)
	end

private

	def category
		@m_category ||= Category.find(params[:category_id])
	end
	helper_method :category

end