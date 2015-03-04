class PriceFade < ActiveRecord::Base

	belongs_to :listing

	validates :start_price, presence: true
	validates :price_interval, presence: true
	validates :price_decrement, presence: true

	
end
