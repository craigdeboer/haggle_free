require 'rails_helper'

RSpec.describe Category, type: :model do
  
  before do
    @category = build(:category)
  end

	it "should have the right attributes" do
  	expect(@category).to respond_to(:name)
  end
  
  it "is valid with a name" do
  	expect(@category).to be_valid
  end
  
  it "is invalid without a name" do
  	@category.name = ""
  	@category.valid?
  	expect(@category.errors[:name]).to include("can't be blank")
  end

end
