class AboveReserveValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		if record.listing_id != nil && bid_too_low(record, value)
			record.errors[attribute] << ' must be above the reserve.'
		end
	end

	private

		def bid_too_low(record, value)
			if record.listing.sell_method == "Auction" && record.listing.auction.show_reserve
				value < record.listing.auction.reserve
			else
				false
			end
		end

end