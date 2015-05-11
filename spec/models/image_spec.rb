require 'rails_helper'

RSpec.describe Image, type: :model do
  
  before do
    listing = create(:price_fade_listing, price_fade_attributes:(attributes_for(:price_fade, listing: listing))) 
  	@image = build(:image, listing: listing)
  end

  it "should have the right attributes" do
  	expect(@image).to respond_to(:listing_id, :picture_file_name, :picture_content_type, :picture_file_size)
  end

  it "is valid with listing id, file name, content type,and file size" do
  	expect(@image).to be_valid
  end

  it "is invalid without a listing id" do
  	@image.listing_id = ''
  	expect(@image).to_not be_valid
  end

  it "is invalid without a file name" do
  	@image.picture_file_name = ''
  	expect(@image).to_not be_valid
  end

  it "is invalid without a valid content_type" do
  	@image.picture_content_type = 'image/eps'
  	expect(@image).to_not be_valid
  end

  it "is valid with a file size that is under 2.5 MB" do
    @image.picture_file_size = '2490000'
    expect(@image).to be_valid
  end

  it "is invalid with a file size that is too large" do
  	@image.picture_file_size = '2622000'
  	expect(@image).to_not be_valid
  end
end
