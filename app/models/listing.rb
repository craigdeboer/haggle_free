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
	validates :end_date, presence: true

	before_validation :set_end_date

	scope :active, -> { where("end_date > ?", DateTime.now) }

	def auction?
		self.sell_method == "Auction"
	end

	def price?
		self.sell_method == "Price"
	end

	def self.user_listings(user)
		Listing.where("user_id = ?", user).includes(:images, :auction, :price_fade, :user).order(created_at: :desc)
	end

	def self.subcategory_listings(subcategory)
		Listing.active.where("sub_category_id = ?", subcategory).includes(:images, :auction, :price_fade, :user).order(created_at: :desc)
	end

private

	def set_end_date
		if self.sell_method == "Auction"
			self.end_date = DateTime.now + (self.auction.end_date.to_date - Date.today).to_i.days
		elsif self.sell_method == "Price"
			self.end_date = DateTime.now + (self.price_fade.price_interval * 7).days
		end
	end


end
