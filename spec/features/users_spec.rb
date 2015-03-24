require 'rails_helper'


describe "User management" do

	context "sign up of new user" do

		before do
			@user = build(:user)
			visit root_path
			click_link "SIGN UP"
			fill_in "First name", with: @user.first_name
			fill_in "Last name", with: @user.last_name
			fill_in "User name", with: @user.user_name
			fill_in "Email", with: @user.email
			fill_in "Password", with: @user.password
			fill_in "Password confirmation", with: @user.password_confirmation
		end

		it "saves a new user" do
			expect{ click_button "Create User" }.to change(User, :count).by(1)
		end

		it "logs in the user immediately after signup" do
			click_button "Create User"
			expect(page).to have_link("LOG OUT")
		end
	end

end