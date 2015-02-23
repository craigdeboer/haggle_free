require 'rails_helper'

RSpec.describe SubCategoriesController, type: :controller do

	before do
		@category = Category.create(name: "Motorized Vehicles")
		@subcategory = SubCategory.create(name: "Motorcycles", category_id: @category.id)
	end

	context "with any user" do
		describe "Get #index" do
			it "will assign @subcategories an array of all the subcategories" do
				get :index
				expect(assigns(:subcategories)).to match_array([@subcategory])
			end
		end
	end

end
