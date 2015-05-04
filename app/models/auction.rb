class Auction < ActiveRecord::Base

	attr_accessor :end_date

	belongs_to :listing

 	validates :reserve, presence: true
	
end
