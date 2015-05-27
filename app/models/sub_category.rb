class SubCategory < ActiveRecord::Base

	belongs_to :category
	has_many :listings
	has_many :expired_listings

	validates :name, presence: true
	validates :category_id, presence: true
	
end
