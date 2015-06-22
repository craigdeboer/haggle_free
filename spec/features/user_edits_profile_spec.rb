require 'rails_helper'
require 'chromedriver'

describe "Editing a user profile" do
	context "successfully", :js => true do
		before do
			@user = create(:user)
			log_in(@user)
			click_link @user.user_name
			click_link "My Profile"
			click_link "Edit Your Profile"
			fill_in "First name", with: "Ralph"
			fill_in "Password", with: @user.password
			fill_in "Password confirmation", with: @user.password
			click_button "Update"
			@user.reload
		end
		it "updates the user" do
			expect(@user.first_name).to eq "Ralph"
		end
	end

end