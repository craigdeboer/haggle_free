require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  
  before do
    @subcategory = SubCategory.new(name: "Motorcycles") 
  end

	it "should have the right attributes" do
  	expect(@subcategory).to respond_to(:name)
  end
  
  it "is valid with a name" do
  	expect(@subcategory).to be_valid
  end
  
  it "is invalid without a name" do
  	@subcategory.name = ""
  	@subcategory.valid?
  	expect(@subcategory.errors[:name]).to include("can't be blank")
  end
end
