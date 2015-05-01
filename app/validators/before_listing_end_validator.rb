class BeforeListingEndValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		if record.listing_id != nil && DateTime.now > record.listing.end_date
			record.errors[:base] << 'Unfortunately, this listing has ended.'
		end
	end

end