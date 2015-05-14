require 'rails_helper'

RSpec.describe Question, type: :model do

  before do
  	listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: listing)))
  	@question = build(:question, listing: listing)
  end

  it "should respond to the right attributes" do
  	expect(@question).to respond_to(:question, :listing_id, :user_id)
  end

  it "is valid with a question, user id, and listing id" do
  	expect(@question).to be_valid
  end

  it "is invalid with a blank question" do
  	@question.question = ""
  	expect(@question).to_not be_valid
  end

  it "is invalid without a user id" do
  	@question.user_id = ""
  	expect(@question).to_not be_valid
  end

  it "is invalid without a listing id" do
  	@question.listing_id = ""
  	expect(@question).to_not be_valid
  end

  it "is valid with a question that is not too long" do
  	@question.question = "a" * 499
  	expect(@question).to be_valid
  end

  it "is invalid with a question that is too long" do
  	@question.question = "characters" * 50
  	expect(@question).to_not be_valid
  end

end
