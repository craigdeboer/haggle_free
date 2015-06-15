class SubCategoryListingsController < ApplicationController

	skip_before_action :require_login

	def index
		@listings = Listing.subcategory_listings(sub_category).page(params[:page]).per_page(10) 
	end

private

	def sub_category
		@m_sub_category ||= SubCategory.find(params[:sub_category_id])
	end
	helper_method :sub_category

	def category
		sub_category.category
	end
	helper_method :category
end