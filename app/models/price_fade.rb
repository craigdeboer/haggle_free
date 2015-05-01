class PriceFade < ActiveRecord::Base

	belongs_to :listing

	scope :active, -> { where("price_fades.end_date > ?", DateTime.now) }

	validates :start_price, presence: true
	validates :price_interval, presence: true
	validates :price_decrement, presence: true

	before_save :set_end_date

	def bid_received
		self.update_column(:sale_pending, true)
	end

private

	def set_end_date
		self.end_date = DateTime.now + (self.price_interval * 7).days
	end
	
end
