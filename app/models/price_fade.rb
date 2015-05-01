class PriceFade < ActiveRecord::Base

	belongs_to :listing

	validates :start_price, presence: true
	validates :price_interval, presence: true
	validates :price_decrement, presence: true

	def bid_received
		self.update_column(:sale_pending, true)
	end
	
end
