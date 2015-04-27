class BeforeListingEndValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		if record.listing_id != nil && DateTime.now > listing_end_date(record)
			record.errors[:base] << 'Unfortunately, this auction has ended.'
		end
	end

	private

		def listing_end_date(record)
			if record.listing.sell_method == "Auction"
				record.listing.auction.end_date.beginning_of_day + 21.hours
			else
				(record.listing.created_at + (record.listing.price_fade.price_interval * 7).days).beginning_of_day + 21.hours
			end
		end

end