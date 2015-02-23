class SubCategoriesController < ApplicationController

	before_action :all_categories_and_subcategories, only: [:index, :create, :destroy]
	respond_to :html, :js

	def index
	end

	def new
		@category = Category.find(params[:id])
		@subcategory = @category.sub_categories.new
	end

	def create
		@category = Category.find(params[:sub_category][:id])
		@subcategory = @category.sub_categories.new(subcategory_params)
		@subcategory.save
	end

	def destroy
		@subcategory = SubCategory.find(params[:id])
		@subcategory.destroy
	end

	private

		def subcategory_params
			params.require(:sub_category).permit(:name)
		end

		def all_categories_and_subcategories
			@categories = Category.all
			@subcategories = SubCategory.all
		end

end
