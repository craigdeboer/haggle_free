require 'rails_helper'

feature "Log in an existing user" do
	scenario "successfully" do
		@user = create(:user)
		log_in @user
		expect(page).to have_css "a", text: @user.user_name
	end
end

feature "Log out a logged in user" do
	scenario "successfully" do
		@user = create(:user)
		log_in @user
		click_on "LOG OUT"
		expect(page).to have_css "a", text: "LOG IN"
	end
end
















