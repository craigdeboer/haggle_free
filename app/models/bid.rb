class Bid < ActiveRecord::Base

	belongs_to :user
	belongs_to :listing, counter_cache: true

	validates :user_id, presence: true, uniqueness: { scope: :listing_id, message: "You have already bid on this item." }
	validates :listing_id, presence: true
	validates :price, presence: true, numericality: { greater_than: 0.01, less_than: 100000 }, above_reserve: true
	validates :created_at, before_listing_end: true

end
