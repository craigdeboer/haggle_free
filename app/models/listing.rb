class Listing < ActiveRecord::Base
	belongs_to :user
	belongs_to :sub_category, counter_cache: true
	has_one :price_fade, dependent: :destroy
	has_one :auction, dependent: :destroy
	has_many :images, dependent: :destroy
	has_many :bids, dependent: :destroy
	accepts_nested_attributes_for :auction, :reject_if => :price?
	accepts_nested_attributes_for :price_fade, :reject_if => :auction?

	validates :title, presence: true, length: { maximum: 99}
	validates :description, presence: true, length: { maximum: 1000}
	validates :sell_method, presence: true
	validates :sub_category_id, presence: true
	validates :user_id, presence: true

	def auction?
		self.sell_method == "Auction"
	end

	def price?
		self.sell_method == "Price"
	end

	def self.active_listings
		auction_listing = Listing.joins(:auction).merge(Auction.active).to_sql
		price_fade_listing = Listing.joins(:price_fade).merge(PriceFade.active).to_sql
		Listing.find_by_sql("(#{auction_listing}) UNION DISTINCT (#{price_fade_listing})")
	end

	def self.user_listings(user)
		Listing.where("user_id = ?", user).includes(:images, :auction, :price_fade, :user).order(created_at: :desc)
	end

	def self.subcategory_listings(subcategory)
		Listing.where("sub_category_id = ?", subcategory).includes(:images, :auction, :price_fade, :user).order(created_at: :desc).merge(Listing.active_listings)
	end


end
