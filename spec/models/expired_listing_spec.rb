require 'rails_helper'

RSpec.describe ExpiredListing, type: :model do
  
  before do
    @expired_listing = build(:expired_listing)
  end

  it "should have the right attributes" do
  	expect(@expired_listing).to respond_to(:original_listing_id, :title, :number_of_bids, :highest_bid, :end_date, :user_id, :sold)
  end

  describe "#convert (converting a listing that has ended)" do

  	before do
  		@listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing_id: @listing)))
  	end

  	it "creates an Expired Listing" do
  		expect{ ExpiredListing.convert(@listing, 3, 450.00) }.to change(ExpiredListing, :count).by(1)
  	end

  end

  describe "#purge (deleting an expired listing that is older than 2 weeks)" do

  	it "deletes the expired listing" do
			@expired_listing = create(:expired_listing)  	
			@expired_listing.created_at = DateTime.now -15.days
			expect{ ExpiredListing.purge }.to change(ExpiredListing, :count).by(-1)
		end


  end
end
