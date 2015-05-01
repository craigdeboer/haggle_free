class Auction < ActiveRecord::Base
	belongs_to :listing

	attr_accessor :end_date

 	validates :reserve, presence: true
	
end
