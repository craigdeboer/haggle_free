require 'rails_helper'
require 'chromedriver'

feature "Bid Management" do

	feature "User bids on listing" do

		before do
				log_in create(:user)
				create_auction_listing
				create_price_fade_listing
			end

		feature "with a listing type of auction" do

			scenario "at a price above the reserve" do
				select_auction_listing
				bid_on_auction
				visit root_path
				expect(page).to have_css "span", text: "(1)"
			end
		end

		feature "with a listing type of price" do

			scenario "as the first buyer" do
				select_price_fade_listing
				bid_on_price_fade
				expect(page).to have_content "Your bid has been accepted"
			end
		end

	end

	feature "User views his/her bids" do

		before do
			log_in create(:user)
			create_auction_listing
			create_price_fade_listing
			select_auction_listing
			bid_on_auction
			visit root_path
			select_price_fade_listing
			bid_on_price_fade
			visit root_path
		end

		scenario "when user has active bids" do
			click_on "My Bids"
			expect(page).to have_content @auction_listing.title
		end


	end

	feature "User deletes a bid" do

		before do
			log_in create(:user)
			create_auction_listing
			select_auction_listing
			bid_on_auction
			visit root_path
		end

		scenario "successfully", js: true do
			click_on "My Bids"
			click_on("Delete", :match => :first)
			page.driver.browser.switch_to.alert.accept
			expect(page).to have_content "Bid successfully deleted."
		end


	end

end









