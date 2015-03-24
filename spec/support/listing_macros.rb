module ListingMacros

	def create_listing(subcategory, listing_type)
		click_link "Create New Listing"
		expect(page).to have_content("New Listing")
		select(@subcategory.name, from: "Sub category")
		fill_in "Title", with: "This Item"
		fill_in "Description", with: "Great item in great shape."
		create_auction if listing_type == "auction"
		create_price_fade if listing_type == "price"
	end

	def create_auction
		choose("Auction")
		fill_in "Reserve", with: "100.0"
		check("Show reserve")
		select(Date.today + 2.days, from: "Auction End Date")
	end

	def create_price_fade
		choose("Price")
		fill_in "Start price", with: "200.00"
		choose("2")
		fill_in "Price decrement", with: "5.00"
	end

end