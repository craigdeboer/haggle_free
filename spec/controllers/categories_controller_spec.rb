require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

	before do
		@category1 = Category.create(name: "Motorized Vehicles")
		@category2 = Category.create(name: "Sporting Goods")
	end

	context "with any user" do
		describe "Get #index" do
			it "will assign @categories an array of all the categories" do
				get :index
				expect(assigns(:categories)).to match_array([@category1, @category2])
			end

			it "renders the index page" do
				get :index
				expect(response).to render_template :index
			end 
		end

		
	end

end
