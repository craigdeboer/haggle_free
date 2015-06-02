class Listing < ActiveRecord::Base
	belongs_to :user
	belongs_to :sub_category, counter_cache: true
	has_many :categories, through: :sub_category
	has_one :price_fade, dependent: :destroy
	has_one :auction, dependent: :destroy
	has_many :images, dependent: :destroy
	has_many :bids
	has_many :questions, dependent: :destroy
	accepts_nested_attributes_for :auction, :reject_if => :price?
	accepts_nested_attributes_for :price_fade, :reject_if => :auction?

	validates :title, presence: true, length: { maximum: 99 }
	validates :description, presence: true, length: { maximum: 1000}
	validates :sell_method, presence: true
	validates :sub_category_id, presence: true
	validates :user_id, presence: true
	validates :end_date, presence: true

	before_validation :set_end_date

	scope :by_newest, -> { order("created_at DESC") }

	def auction?
		self.sell_method == "Auction"
	end

	def price?
		self.sell_method == "Price"
	end

	def self.listings_select(params)
		if params[:category_id]
			@category = Category.find(params[:category_id])
    	@listings = @category.listings.includes(:images, :auction, :price_fade, :user).all.by_newest	
    elsif params[:sub_category_id]
    	@subcategory = SubCategory.find(params[:sub_category_id])
    	@listings = Listing.subcategory_listings(@subcategory).by_newest
    else
    	@listings = Listing.where("created_at > ?", 24.hours.ago).includes(:images, :auction, :price_fade, :user).by_newest
    end
	end

	def self.user_listings(user)
		Listing.where("user_id = ?", user).includes(:images, :auction, :price_fade, :user).by_newest
	end

	def self.subcategory_listings(subcategory)
		Listing.where("sub_category_id = ?", subcategory).includes(:images, :auction, :price_fade, :user).order(created_at: :desc)
	end

	def self.recently_ended
		expired_listings = Listing.where("end_date < ?", DateTime.now).includes(:bids)
		expired_listings.each do |listing|
			@bids = Bid.get_bids(listing.id)
			bid_count = @bids.length
			highest_bid = @bids[0].price.to_f if bid_count != 0
			ExpiredListing.convert(listing, bid_count, highest_bid)
			send_summary_email(listing, @bids)
			listing.destroy
		end
	end

private

	def self.send_summary_email(listing, bids)
		bids_summary = bid_details(bids)
		seller_email = listing.user.email
		listing_title = listing.title
		UserMailer.listing_expired(seller_email, listing_title, bids_summary).deliver_later
	end

	def self.bid_details(bids)
		bid_details_array = []
		temp_array = []
		bids.each do |bid|
			temp_array << bid.user.user_name << bid.price.to_f << bid.user.email
			bid_details_array << temp_array
		end
		bid_details_array
	end

	def set_end_date
		if self.sell_method == "Auction"
			self.end_date = DateTime.now + (self.auction.end_date.to_date - Date.today).to_i.days
		elsif self.sell_method == "Price"
			self.end_date = DateTime.now + (self.price_fade.price_interval * 7).days
		end
	end


end
