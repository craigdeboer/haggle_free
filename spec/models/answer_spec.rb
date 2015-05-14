require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  before do
  	listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: listing)))
  	question = create(:question, listing: listing)
  	@answer = build(:answer, question: question)
  end

  it "should respond to the right attributes" do
  	expect(@answer).to respond_to(:answer, :question_id)
  end

  it "is valid with an answer and a question id" do
  	expect(@answer).to be_valid
  end

  it "is invalid with a blank answer" do
  	@answer.answer = ""
  	expect(@answer).to_not be_valid
  end

  it "is invalid without a question id" do
  	@answer.question_id = ""
  	expect(@answer).to_not be_valid
  end

  it "is valid with an answer that is not too long" do
  	@answer.answer = "characters" * 100
  	expect(@answer).to be_valid
  end

  it "is invalid with a question that is too long" do
  	@answer.answer = "characters" * 101
  	expect(@answer).to_not be_valid
  end

end
