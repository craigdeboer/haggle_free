require 'rails_helper'

feature "User bids on listing" do

	feature "with a listing type of auction" do

		before do
			log_in create(:user)
			@subcategory = create(:sub_category)
			@listing = create(:listing, sub_category_id: @subcategory.id)
			@auction = create(:auction, listing_id: @listing.id)
			select_a_listing @subcategory, @listing
			click_button "Bid On This Item"
		end

		scenario "at a price above the reserve" do
			fill_in "Price", with: "100.00"
			click_button "Submit Your Bid"
			visit root_path
			expect(page).to have_css "span", text: "(1)"
		end
	end

	feature "with a listing type of price" do

		before do
			log_in create(:user)
			@subcategory = create(:sub_category)
			@listing = create(:listing, sub_category_id: @subcategory.id, sell_method: "Price")
			@price_fade = create(:price_fade, listing_id: @listing.id)
			select_a_listing @subcategory, @listing
			click_on "Submit Offer To Buy At The Current Price"
		end

		scenario "as the first buyer" do
			click_button "Confirm"
			expect(page).to have_content "Your bid has been accepted"
		end
	end

end