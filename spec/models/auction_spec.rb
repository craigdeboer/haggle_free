require 'rails_helper'

RSpec.describe Auction, type: :model do
  
  before do
    @listing = build(:auction_listing)
  	@auction = build(:auction, listing_id: @listing.id)
  end

  it "should have the right attributes" do
  	expect(@auction).to respond_to(:reserve, :show_reserve, :end_date)
  end

  it "is valid with a reserve" do
  	expect(@auction).to be_valid
  end

  it "is invalid without a reserve" do
  	@auction.reserve = ""
  	expect(@auction).to_not be_valid
  end

  it "has a belongs to association with listing" do
  	@auction = @listing.build_auction(attributes_for(:auction))
  	expect(@auction).to be_valid
  end

  it "is saved when a listing is saved with the Auction attributes nested in it" do
    @listing = build(:auction_listing, auction_attributes:(attributes_for(:auction)))
    expect{ @listing.save }.to change(Auction, :count).by(1)
  end
end
