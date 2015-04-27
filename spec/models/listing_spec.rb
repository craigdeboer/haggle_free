require 'rails_helper'

RSpec.describe Listing, type: :model do
  
  before do
  	@listing = build(:listing)
  end

  it "should have the right attributes" do
  	expect(@listing).to respond_to(:title, :description, :sell_method, :sub_category_id, :user_id)
  end

  it "is valid with title, description, sell method, post date, subcategory id, and user id" do
  	expect(@listing).to be_valid
  end

  it "is invalid without a title" do
  	@listing.title = ""
  	expect(@listing).to_not be_valid
  end

  it "is invalid with a title that is too long" do
  	@listing.title = "tenletters" * 10
  	expect(@listing).to_not be_valid
  end

  it "is invalid without a description" do
  	@listing.description = ""
  	expect(@listing).to_not be_valid
  end

  it "is invalid with a description that is too long" do
  	@listing.description = "This is a long sentence. " * 41
  	expect(@listing).to_not be_valid
  end

  it "is invalid without a sell method" do
  	@listing.sell_method = ""
  	expect(@listing).to_not be_valid
  end

  it "is invalid without a subcategory id" do
  	@listing.sub_category_id = ""
  	expect(@listing).to_not be_valid
  end

  it "is invalid without a user id" do
  	@listing.user_id = ""
  	expect(@listing).to_not be_valid
  end


end


