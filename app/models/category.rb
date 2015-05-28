class Category < ActiveRecord::Base

	has_many :sub_categories
	has_many :listings, through: :sub_categories

	validates :name, presence: true
	
end
