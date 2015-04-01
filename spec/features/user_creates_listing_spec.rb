require 'rails_helper'
require 'chromedriver'


feature "User creates a new listing" do

	before do
		@user = create(:user)
		log_in(@user)
		@subcategory = create(:sub_category)
		visit root_path
	end

	scenario "successfully" do
		create_listing(@subcategory, "auction")
		expect(page).to have_css "div.title", text: "This Item"
	end

	scenario "successfully with a sell method of auction" do
		create_listing(@subcategory, "auction")
		expect(page).to have_css "li", text: "Listing Type: Auction"
	end

	scenario "with a sell method of auction", js: true do
		create_listing(@subcategory, "price")
		expect(page).to have_css "li", text: "Listing Type: Price"
	end
	
end
