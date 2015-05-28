class SubCategoriesController < ApplicationController

	skip_before_action :require_login, only: :index
	before_action :all_categories_and_subcategories, only: [:index, :create, :destroy]
	before_action :require_admin, only: [:new, :destroy]
	respond_to :html, :js

	def index
	end

	def new
		@category = Category.find(params[:category_id])
		@subcategory = @category.sub_categories.new
	end

	def create
		@category = Category.find(params[:category_id])
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
			@categories = Category.includes(:sub_categories).all
		end

		def require_admin
			if !admin?
				flash[:notice] = "You must be an admin user to access the requested page."
				redirect_to root_path
			end
		end

end
