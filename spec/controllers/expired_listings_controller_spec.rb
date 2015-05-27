require 'rails_helper'

RSpec.describe ExpiredListingsController, type: :controller do

	before do
		@user = create(:user)
		@subcategory = create(:sub_category)
		@expired_listing1 = create(:expired_listing, sub_category: @subcategory)
		@expired_listing2 = create(:expired_listing, sub_category: @subcategory)
		@expired_listing3 = create(:expired_listing)
		@expired_listing4 = create(:expired_listing, user: @user)
	end

	context "with a non-logged in user" do
		describe "GET #index" do
			it "assigns an array of all expired listings to @expired_listings" do
				get :index
				expect(assigns(:expired_listings)).to match_array [@expired_listing1, @expired_listing2, @expired_listing3, @expired_listing4]
			end
			it "renders the index template" do
				get :index
				expect(response).to render_template :index
			end
		end

		describe "GET #subcategory" do
			it "assigns an array of all expired listings for a particular subcategory to @expired_listings" do
				get :subcategory, sub_category_id: @subcategory.id
				expect(assigns(:expired_listings)).to match_array [@expired_listing1, @expired_listing2]
			end
		end
	end

	context "with a logged in user" do
		before { allow(controller).to receive(:current_user) { @user } }
		describe "POST #mark_as_sold" do
			before { post :mark_as_sold, id: @expired_listing4.id }
			it "sets the sold attribute to true for the given expired_listing" do
				@expired_listing4.reload
				expect(@expired_listing4.sold).to eq true
			end
			it "assigns the correct expired_listing to @expired_listing" do
				expect(assigns(:expired_listing)).to eq @expired_listing4
			end
			it "redirects to the user's listings page" do
				expect(response).to redirect_to user_listings_path
			end
		end
	end
end