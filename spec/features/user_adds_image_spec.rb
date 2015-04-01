require 'rails_helper'

feature "Adding an image to a listing" do

	scenario "successfully" do
		@user = create(:user)
		@listing = create(:listing, user_id: @user.id)
		@auction = create(:auction, listing_id: @listing.id)
		log_in(@user)
		click_on "My Listings"
		click_on @listing.title
		click_on "Add Picture"
		page.attach_file("Picture", "#{Rails.root}/public/pictures/klr4.jpeg")
		expect{ click_button "Add Picture" }.to change(Image, :count).by(1)
	end
end
