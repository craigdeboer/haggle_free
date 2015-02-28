class Auction < ActiveRecord::Base
	belongs_to :listing

 	validates :reserve, presence: true
	validates :end_date, presence: true

end
