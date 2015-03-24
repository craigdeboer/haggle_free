require 'rails_helper'
require 'chromedriver'


describe "Creating a new listing" do

	before do
		@user = create(:user)
		log_in(@user)
		@subcategory = create(:sub_category)
		visit root_path
	end

	context "with a sell method of auction" do

		before { create_listing(@subcategory, "auction") }

		it "saves the new listing" do	
			expect{ click_button "Create Listing" }.to change(Listing, :count).by(1)
		end
		it "saves the new auction" do	
			create_listing(@subcategory, "auction")
			expect{ click_button "Create Listing" }.to change(Auction, :count).by(1)
		end

	end

	context "with a sell method of price fade", js: true do

		before { create_listing(@subcategory, "price") }

		it "saves the new listing" do	
			expect{ click_button "Create Listing" }.to change(Listing, :count).by(1)
		end
		it "saves the new price fade" do	
			expect{ click_button "Create Listing" }.to change(PriceFade, :count).by(1)
		end
	end

end
