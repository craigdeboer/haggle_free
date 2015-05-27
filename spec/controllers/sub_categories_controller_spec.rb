require 'rails_helper'

RSpec.describe SubCategoriesController, type: :controller do

	before do
		@admin = create(:admin)
		@category = create(:category)
		@subcategory1 = create(:sub_category, category: @category)
		@subcategory2 = create(:sub_category, category: @category)
		@subcategory3 = create(:sub_category)
	end

	context "with non logged_in user" do
		describe "Get #index" do
			it "will assign @subcategories an array of all the subcategories" do
				get :index
				expect(assigns(:subcategories)).to match_array [@subcategory1, @subcategory2, @subcategory3]
			end
		end
	end
	context "with admin user" do
		before { allow(controller).to receive(:current_user) { @admin } }
		describe "GET #new" do
			before { xhr :get, :new, category_id: @category.id, format: "js" }
			it "assigns a new instance of Subcategory with the associated category to @subcategory" do
				expect(assigns(:subcategory)).to be_a_new(SubCategory).with(category_id: @category.id)
			end 
		end
		describe "POST #create" do
			it "saves the Subcategory to the database" do
				expect{
					post :create, category_id: @category.id, sub_category:{ name: "Bikes" }, format: "js"
				}.to change(SubCategory, :count).by(1)
			end
		end
		describe "DELETE #destroy" do
			it "deletes the Subcategory from the database" do
				expect{
					delete :destroy, id: @subcategory1.id, format: "js"
				}.to change(SubCategory, :count).by(-1)
			end
		end
	end
end
