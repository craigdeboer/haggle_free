class CategoriesController < ApplicationController

	before_action :all_categories, only: [:index, :create, :destroy]
	respond_to :html, :js
	
	def index
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Success"
		else
			flash[:notice] = "Something Went Wrong"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		flash[:notice] = "Category successfully deleted."
	end

	private

		def category_params
			params.require(:category).permit(:name)
		end

		def all_categories
			@categories = Category.all
		end
end
