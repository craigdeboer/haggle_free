require 'rails_helper'

RSpec.describe PriceFade, type: :model do
 
	before do
  	@price_fade = build(:price_fade)
  end

  it "should have the right attributes" do
  	expect(@price_fade).to respond_to(:start_price, :end_price, :end_date)
  end

  it "is valid with a start price, end price, and end_date" do
  	expect(@price_fade).to be_valid
  end

  it "is invalid without a start price" do
  	@price_fade.start_price = ""
  	expect(@price_fade).to_not be_valid
  end

  it "is invalid without an end price" do
  	@price_fade.end_price = nil
  	expect(@price_fade).to_not be_valid
  end

  it "is invalid without an end date" do
  	@price_fade.end_date = ""
  	expect(@price_fade).to_not be_valid
  end

  it "has belongs to association with listing" do
  	@listing = build(:listing)
  	@price_fade = @listing.build_price_fade(attributes_for(:price_fade))
  	expect(@price_fade).to be_valid
  end

  it "is saved when a listing is saved with the price_fade attributes nested in it" do
    @listing = build(:listing, price_fade_attributes:(attributes_for(:price_fade)))
    expect{ @listing.save }.to change(PriceFade, :count).by(1)
  end
end
