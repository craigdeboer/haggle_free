class Bid < ActiveRecord::Base

	attr_writer :price_string

	belongs_to :user
	belongs_to :listing, counter_cache: true


	validates :user_id, presence: true, uniqueness: { scope: :listing_id, message: "You have already bid on this item." }
	validates :listing_id, presence: true
	validates :price, presence: true, numericality: { greater_than: 0.01, less_than: 100000 }, above_reserve: true
	validates :created_at, before_listing_end: true

	before_validation :strip_dollar_sign

	def price_string
		@price_string || ("$" + price.to_s if price)
	end

private

	def strip_dollar_sign
		if (price_string.tr('$', '') =~ /\A\d+\.?\d*\Z/) != nil
			self.price = price_string.tr('$', '').to_f
		else
			self.price = price_string
		end
	end
end
