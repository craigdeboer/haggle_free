require 'rails_helper'
require 'chromedriver'


feature "User answers a question" do

	before do
		@user = create(:user)
		log_in(@user)
		@listing = create(:auction_listing, user: @user, auction_attributes:(attributes_for(:auction, listing: @listing)))
		@question = create(:question, listing: @listing)
		visit root_path
		click_on "My Listings"
		click_link @listing.title
		click_on "Answer Question"
		fill_in "Answer", with: "Yes, there are three."	
	end

	scenario "successfully" do
		expect { click_on "Create Answer" }.to change(Answer, :count).by(1)
	end

	
	
end
