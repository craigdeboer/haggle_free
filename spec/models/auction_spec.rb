require 'rails_helper'

RSpec.describe Auction, type: :model do
  
  before do
  	@auction = build(:auction)
  end

  it "should have the right attributes" do
  	expect(@auction).to respond_to(:reserve, :show_reserve, :end_date)
  end

  it "is valid with a reserve, show reserve, and end_date" do
  	expect(@auction).to be_valid
  end

  it "is invalid without a reserve" do
  	@auction.reserve = ""
  	expect(@auction).to_not be_valid
  end

  it "is invalid without a show reserve" do
  	@auction.show_reserve = nil
  	expect(@auction).to_not be_valid
  end

  it "is invalid without an end date" do
  	@auction.end_date = ""
  	expect(@auction).to_not be_valid
  end

  it "has a belongs to association with listing" do
  	@listing = build(:listing)
  	@auction = @listing.build_auction(attributes_for(:auction))
  	expect(@auction).to be_valid
  end

  it "is saved when a listing is saved with the Auction attributes nested in it" do
    @listing = build(:listing, auction_attributes:(attributes_for(:auction)))
    expect{ @listing.save }.to change(Auction, :count).by(1)
  end
end
