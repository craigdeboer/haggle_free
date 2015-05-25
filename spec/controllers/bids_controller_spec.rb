require 'rails_helper'

RSpec.describe BidsController, type: :controller do

	before do
		@craig = create(:user)
		@peter = create(:user)
		@listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: @listing)))
		@craig_bid = create(:bid, user: @craig, listing: @listing)
		@peter_bid = create(:bid, user: @peter, listing: @listing)
	end

	context "with a logged-in user" do

		before { allow(controller).to receive(:current_user) { @craig } }

		describe "GET #index" do
			it "populates an array of the current user's bids" do
				get :index, listing_id: @listing.id
				expect(assigns(:bids)).to match_array [@craig_bid, @peter_bid]
			end
			it "renders the index template" do
				get :index, listing_id: @listing.id
				expect(response).to render_template :index
			end
		end
		
		describe "GET #user" do
			it "populates an array of the current user's bids" do
				get :user
				expect(assigns(:bids)).to match_array [@craig_bid]
			end
			it "renders the index template" do
				get :user
				expect(response).to render_template :index
			end
		end

		describe "GET #new" do
			it "assigns a new Bid associated with the selected listing to @bid" do
				get :new, listing_id: @listing.id
				expect(assigns(:bid)).to be_a_new(Bid).with(listing_id: @listing.id)
			end
		end

		describe "POST #create" do

			before do
			 @new_listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: @new_listing)))
			end
	
			context "with valid attributes" do
				it "saves the new bid in the database" do
					expect {
						post :create, listing_id: @new_listing.id, bid: { price: 125.00, listing_id: @new_listing }
					}.to change(Bid, :count).by(1)
				end
			end
		end

		describe "GET #edit" do
			context "when bid belongs to the current user" do
				it "assigns the correct bid to @bid" do
					get :edit, id: @craig_bid.id
					expect(assigns(:bid)).to eq(@craig_bid)
				end
			end
			context "when bid belongs to a user other than the current user" do
				it "redirects to the root path" do
					get :edit, id: @peter_bid
					expect(response).to redirect_to root_path
				end
			end
		end

		describe "PATCH #update" do
			context "with valid attributes" do
				before {patch :update, id: @craig_bid.id, bid:{price_string: "$144.00"}}
				it "locates the requested bid" do
					expect(assigns(:bid)).to eq @craig_bid
				end
				it "changes the price attriubute" do
					@craig_bid.reload
					expect(@craig_bid.price).to eq 144.00
				end
				it "redirects to the users bids page" do
					expect(response).to redirect_to user_bids_path
				end
			end
		end

		describe "DELETE #destroy" do
				it "locates the requested bid" do
					delete :destroy, id: @craig_bid.id
					expect(assigns(:bid)).to eq @craig_bid
				end
				it "deletes the bid" do
					expect{ delete :destroy, id: @craig_bid.id }.to change(Bid, :count).by(-1)
				end
				it "redirects to the users bids page" do
					delete :destroy, id: @craig_bid.id
					expect(response).to redirect_to user_bids_path
				end
		end
	end
end
