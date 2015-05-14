require 'rails_helper'
require 'chromedriver'


feature "User visiting user_listings" do

	before do
		@user = create(:user)
		visit user_listings_path
	end

	scenario "when not logged in is redirected to the login page" do
		expect(page).to have_content "You must be logged in"
	end

	scenario "when not logged in is redirected to the user_listings page after login" do
		fill_in "Email", with: @user.email
		fill_in "Password", with: @user.password
		click_button "Log In"
		expect(page).to have_content "Here are your listings"
	end

	


	
	
end