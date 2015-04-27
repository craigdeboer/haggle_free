require 'rails_helper'

require 'pp'

RSpec.describe BidsController, type: :controller do

	before do
		@craig = create(:user)
		@peter = create(:user)
		@auction = create(:auction)
		@craig_bid = create(:bid, user_id: @craig.id, listing_id: @auction.listing_id)
		@peter_bid = create(:bid, user_id: @peter.id, listing_id: @auction.listing_id)
	end

	context "with a logged-in user" do

		before { allow(controller).to receive(:current_user) { @craig } }
		
		describe "GET #index" do
			it "populates an array of the current user's bids" do
				get :index
				expect(assigns(:bids)).to match_array [@craig_bid]
			end
			it "renders the index template" do
				get :index
				expect(response).to render_template :index
			end
		end

		describe "GET #new" do
			it "assigns a new Bid associated with the selected listing to @bid" do
				get :new, listing_id: @auction.listing_id
				expect(assigns(:bid)).to be_a_new(Bid).with(listing_id: @auction.listing_id)
			end
		end

		describe "POST #create" do

			before do
			 @new_auction = create(:auction) 
			end
	
			context "with valid attributes" do
				it "saves the new bid in the database" do
					expect {
						post :create, listing_id: @new_auction.listing_id, bid: { price: 125.00, listing_id: @new_auction.listing_id }
					}.to change(Bid, :count).by(1)
				end
			end
		end

	end
end
