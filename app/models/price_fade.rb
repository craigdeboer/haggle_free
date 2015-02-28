class PriceFade < ActiveRecord::Base

	belongs_to :listing

	validates :start_price, presence: true
	validates :end_price, presence: true
	validates :end_date, presence: true

	
end
