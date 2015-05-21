class Bid < ActiveRecord::Base

	attr_writer :price_string

	belongs_to :user
	belongs_to :listing, counter_cache: true


	validates :user_id, presence: true, uniqueness: { scope: :listing_id, message: "You have already bid on this item." }
	validates :listing_id, presence: true
	validates :price, presence: true, numericality: { greater_than: 0.01, less_than: 100000 }, above_reserve: true
	validates :created_at, before_listing_end: true

	before_validation :strip_dollar_sign
	after_save :set_sale_pending

	def price_string
		@price_string || ("$" + price.to_s if price)
	end

	def self.get_bids(listing_id)
		@bids = Bid.where("listing_id = ?", listing_id).order(price: :desc)
	end

	def self.purge(listing_id)
		@expired_bids = Bid.where("listing_id = ?", listing_id)
		@expired_bids.each do |expired_bid|
			expired_bid.destroy
		end
	end

private

	def strip_dollar_sign
		# If price_string is present (if not, price is used in the form submission and no action is needed).
		if price_string
			# Remove the dollar sign and see if input is an acceptable format with only numbers and a single decimal point (the conditional statement will return nil if the input doesn't match the regex).
			if (price_string.tr('$', '') =~ /\A\d+\.?\d*\Z/) != nil
				# Set the price attribute to the value of the input without the dollar sign and convert to a floating point.
				self.price = price_string.tr('$', '').to_f
			else
				# If the input is not a valid format, set the value of the price attribute to the invalid format. The price attribute will then fail the numericality validation instead of the presence validation (if the price attribute wasn't set) and will give the user the correct error message when the form is rendered again.
				self.price = price_string
			end
		end
	end

	def set_sale_pending
		self.listing.price_fade.bid_received if self.listing.sell_method == "Price"
	end
end
