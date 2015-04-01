module BidMacros

	def select_a_listing(subcategory, listing)
		visit root_path
		click_link subcategory.name
		click_link listing.title
	end

end