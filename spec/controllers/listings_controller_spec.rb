require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

	before do
		@user = create(:user)
		@subcategory = create(:sub_category)
		@auction_listing1 = create(:auction_listing, sub_category: @subcategory, user: @user, auction_attributes:(attributes_for(:auction, listing: @auction_listing1)))
		@auction_listing2 = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: @auction_listing1)))
		@price_fade_listing1 = create(:price_fade_listing, sub_category: @subcategory, price_fade_attributes:(attributes_for(:price_fade, listing: @auction_listing1)))
		@price_fade_listing2 = create(:price_fade_listing, user: @user, price_fade_attributes:(attributes_for(:price_fade, listing: @auction_listing1)))
	end

  context "with a non logged-in user" do
		describe "GET #index" do
			it "assigns all recent listings to @listings" do
				@price_fade_listing2.created_at = 2.days.ago
				@price_fade_listing2.save
				get :index
      	expect(assigns(:listings)).to match_array [@auction_listing1, @auction_listing2, @price_fade_listing1]
			end
			it "renders the index template" do
				get :index
				expect(response).to render_template :index
			end
		end 
		describe "GET #subcategory" do
			it "assigns all the listings with the given subcategory to @listings" do
				get :subcategory, sub_category_id: @subcategory.id
				expect(assigns(:listings)).to match_array [@auction_listing1, @price_fade_listing1]
			end
			it "renders the subcategory template" do
				get :subcategory, sub_category_id: @subcategory.id
				expect(response).to render_template :subcategory
			end
		end
		describe "GET #category" do
			it "assigns all the listings with the given category to @listings" do
				get :category, category_id: @subcategory.category.id
				expect(assigns(:listings)).to match_array [@auction_listing1, @price_fade_listing1]
			end
			it "renders the category template" do
				get :category, category_id: @subcategory.category.id
				expect(response).to render_template :category
			end
		end
		describe "GET #show" do
			before { get :show, id: @price_fade_listing1.id }
			it "assigns the correct listing to @listing" do
				expect(assigns(:listing)).to eq @price_fade_listing1
			end
			it "renders the show template" do
				expect(response).to render_template :show
			end
		end
	end

	context "with a logged-in user" do
		before { allow(controller).to receive(:current_user) { @user } }
		describe "GET #user" do
			before { get :user }
			it "assigns the current user's listings to @listings" do
				expect(assigns(:listings)).to match_array [@auction_listing1, @price_fade_listing2]
			end
			it "renders the user template" do
				expect(response).to render_template :user
			end
		end
		describe "GET #user_show" do
			before { get :user_show, id: @price_fade_listing2.id }
			it "assigns the correct listing to @listing" do
				expect(assigns(:listing)).to eq @price_fade_listing2
			end
			it "renders the show template" do
				expect(response).to render_template :show
			end
		end
		describe "GET #new"	do
			before { get :new }
			it "assigns a new listings to @listing" do
				expect(assigns(:listing)).to be_a_new(Listing)
			end
			it "renders the new template" do
				expect(response).to render_template :new
			end
		end
		describe "POST #create" do
			context "with nested auction attributes" do
				it "saves the listing to the database" do
					expect{
						post :create, listing: attributes_for(:auction_listing, sub_category_id: 5, auction_attributes: attributes_for(:auction))
					}.to change(Listing, :count).by(1)
				end
				it "saves the auction to the database" do
					expect{
						post :create, listing: attributes_for(:auction_listing, sub_category_id: 5, auction_attributes: attributes_for(:auction))
					}.to change(Auction, :count).by(1)
				end
			end
			context "with nested price fade attributes" do
				it "saves the listing to the database" do
					expect{
						post :create, listing: attributes_for(:price_fade_listing, sub_category_id: 5, price_fade_attributes: attributes_for(:price_fade))
					}.to change(Listing, :count).by(1)
				end
				it "saves the price fade to the database" do
					expect{
						post :create, listing: attributes_for(:price_fade_listing, sub_category_id: 5, price_fade_attributes: attributes_for(:price_fade))
					}.to change(PriceFade, :count).by(1)
				end
			end
		end
		describe "GET #edit" do
			it "assigns the correct listing to @listing" do
				get :edit, id: @auction_listing1.id
				expect(assigns(:listing)).to eq @auction_listing1
			end
			context "when accessing a listing belonging to the current user" do
				it "renders the edit template" do
					get :edit, id: @auction_listing1.id
					expect(response).to render_template :edit
				end
			end
			context "when accessing a listing belonging to a user other than the current user" do
				it "renders the home page" do
					get :edit, id: @auction_listing2.id
					expect(response).to redirect_to root_path
				end
			end
		end
		describe "PATCH #update" do
			before { patch :update, id: @auction_listing1.id, listing: attributes_for(:auction_listing, sub_category_id: 5, title: "New Name", auction_attributes: attributes_for(:auction)) }
			it "assigns the correct listing to @listing" do
				expect(assigns(:listing)).to eq @auction_listing1
			end
			it "saves the changes to the database" do
				@auction_listing1.reload	
				expect(@auction_listing1.title).to eq "New Name"
			end
			it "redirects to the listing show page" do
				expect(response).to redirect_to @auction_listing1
			end
		end
		describe "DELETE #destroy" do
			it "assigns the correct listing to @listing" do
				delete :destroy, id: @auction_listing1.id
				expect(assigns(:listing)).to eq @auction_listing1
			end
			it "deletes the listing" do
				expect{
					delete :destroy, id: @auction_listing1.id
					}.to change(Listing, :count).by(-1)
			end
			it "deletes the associated auction" do
				expect{
					delete :destroy, id: @auction_listing1.id
					}.to change(Auction, :count).by(-1)
			end
		end
	end
end
