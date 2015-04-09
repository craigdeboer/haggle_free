module BidMacros

	def select_auction_listing
		visit root_path
		click_link @auction_subcategory.name
		click_link @auction_listing.title
	end

	def select_price_fade_listing
		visit root_path
		click_link @price_fade_subcategory.name
		click_link @price_fade_listing.title
	end

	def create_auction_listing
		@auction_subcategory = create(:sub_category)
		@auction_listing = create(:listing, sub_category_id: @auction_subcategory.id)
		@auction = create(:auction, listing_id: @auction_listing.id)
	end

	def create_price_fade_listing
		@price_fade_subcategory = create(:sub_category)
		@price_fade_listing = create(:listing, sell_method: "Price", sub_category_id: @price_fade_subcategory.id)
		@price_fade = create(:price_fade, listing_id: @price_fade_listing.id)
	end

	def bid_on_auction
		click_button "Bid On This Item"
		fill_in "Enter Your Bid", with: "100.00"
		click_button "Submit Your Bid"
	end

	def bid_on_price_fade
		click_on "Submit Offer To Buy At The Current Price"
		click_button "Confirm Your Offer"
	end

end