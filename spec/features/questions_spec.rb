require 'rails_helper'
require 'chromedriver'


feature "User asks a question" do

	before do
		log_in(create(:user))
		@listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: @listing)))
		visit root_path
		click_link @listing.sub_category.name
		click_link @listing.title
		click_button "Ask The Seller A Question"
		fill_in "Question", with: "How many do you have?"	
	end

	scenario "successfully" do
		expect { click_on "Create Question" }.to change(Question, :count).by(1)
	end

	scenario "successfully and listing owner is able to view the question" do
		click_on "Create Question"
		click_link "LOG OUT"
		log_in(@listing.user)
		click_on "My Listings"
		click_on @listing.title
		expect(page).to have_content "How many do you have?"
	end
	
end
