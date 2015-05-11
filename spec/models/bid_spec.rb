require 'rails_helper'

RSpec.describe Bid, type: :model do
  
  before do
    @listing = create(:auction_listing, auction_attributes:(attributes_for(:auction)))
  	@bid = build(:bid, listing_id: @listing.id)
  end

  it "should have the right attributes" do
  	expect(@bid).to respond_to(:user_id, :listing_id, :price, :price_string)
  end

  it "is valid with user id, listing id, and price" do
  	expect(@bid).to be_valid
  end

  it "is invalid without a user_id" do
  	@bid.user_id = ""
  	expect(@bid).to_not be_valid
  end

  it "is invalid without a listing_id" do
    @bid.listing_id = ""
    expect(@bid).to_not be_valid
  end

  it "is invalid without a user_id" do
    @bid.price = ""
    expect(@bid).to_not be_valid
  end

  context "using the price attribute" do 

    it "is invalid with a bid over 99999.99" do
      @bid.price = "100000"
      expect(@bid).to_not be_valid
    end

    it "is invalid with a negative bid" do
      @bid.price = "-1"
      expect(@bid).to_not be_valid
    end

    it "is invalid with a bid containing anything other than numbers and a decimal point" do
      @bid.price = "a1234"
      expect(@bid).to_not be_valid
    end

    it "is invalid if a user has already bid on a listing" do
      @bid.save
      @bid2 = build(:bid, listing_id: @bid.listing_id, user_id: @bid.user_id)
      expect(@bid2).to_not be_valid
    end

    it "is valid if the bid is being entered before the auction end date" do
      expect(@bid).to be_valid
    end

    it "is invalid if the bid is being entered after the auction end date" do
      @bid.listing.end_date = DateTime.now - 2.days
      expect(@bid).to_not be_valid
    end

    it "is invalid if the bid is being entered after the price fade end date" do
      @new_listing = create(:price_fade_listing, price_fade_attributes:(attributes_for(:price_fade, price_interval: -1)))
      @new_bid = build(:bid, listing_id: @new_listing.id)
      expect(@new_bid).to_not be_valid
    end
  end

  context "using the price_string attribute" do

    it "is valid with an input of numbers and a decimal point" do
      @bid.price = nil
      @bid.price_string = "$100.36"
      expect(@bid).to be_valid
    end

    it "is invalid if it contains anything other than numbers and a decimal point" do
      @bid.price = nil
      @bid.price_string = "$100.g36"
      expect(@bid).to_not be_valid
    end

  end



end







