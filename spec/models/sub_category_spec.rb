require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  
  before do
    @subcategory = build(:sub_category) 
  end

	it "should have the right attributes" do
  	expect(@subcategory).to respond_to(:name, :category_id)
  end
  
  it "is valid with a name and category_id" do
  	expect(@subcategory).to be_valid
  end
  
  it "is invalid without a name" do
  	@subcategory.name = ""
  	@subcategory.valid?
  	expect(@subcategory.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a category_id" do
    @subcategory.category_id = ""
    expect(@subcategory).to_not be_valid
  end
end
