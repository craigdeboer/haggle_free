class Listing < ActiveRecord::Base
	belongs_to :user
	belongs_to :sub_category
	has_one :price_fade
	has_one :auction
	accepts_nested_attributes_for :auction, :reject_if => :price_selected
	accepts_nested_attributes_for :price_fade, :reject_if => :auction_selected

	validates :title, presence: true, length: { maximum: 99}
	validates :description, presence: true, length: { maximum: 290}
	validates :sell_method, presence: true
	validates :post_date, presence: true
	validates :sub_category_id, presence: true
	validates :user_id, presence: true

	# def auction_selected
	# 	return true if self.sell_method == "Auction"
	# end

	def auction_selected
		return true if self.sell_method == "Auction"
	end

	def price_selected
		return true if self.sell_method == "Price"
	end


end
