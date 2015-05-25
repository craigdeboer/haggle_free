require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

	before do
		@admin = create(:admin)
		@category1 = create(:category)
		@category2 = create(:category)
	end

	context "with a logged in admin user" do
		before { allow(controller).to receive(:current_user) { @admin } }
		describe "GET #index" do
			it "will assign @categories an array of all the categories" do
				get :index
				expect(assigns(:categories)).to match_array([@category1, @category2])
			end
			it "renders the index page" do
				get :index
				expect(response).to render_template :index
			end 
		end

		describe "GET #new" do
			it "assigns a new Category to @category" do
				xhr :get, :new, format: "js"
				expect(assigns(:category)).to be_a_new(Category)
			end
		end

		describe "POST #create" do
			it "adds the category to the database" do
				expect{
					post :create, category: attributes_for(:category), format: "js"
				}.to change(Category, :count).by(1)
			end
		end

		describe "DELETE #destroy" do
			it "assigns the correct category to @category" do
				delete :destroy, id: @category1.id, format: "js"
				expect(assigns(:category)).to eq @category1
			end
			it "removes the category from the database" do
				expect{
					delete :destroy, id: @category1.id, format: "js"
				}.to change(Category, :count).by(-1)
			end
		end
	end

end
