require 'rails_helper'

describe "User Log In and Log Out" do

	before do
		@user = create(:user)
		visit root_path
		click_link "LOG IN"
	end

	it "logs in valid user with matching email and password" do	
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: @user.password
		click_button 'Log In'
		expect(page).to have_link "LOG OUT"
	end

	it "doesn't log in the user if email doesn't exist" do
		fill_in 'Email', with: "kennyg@hotmail.com"
		fill_in 'Password', with: @user.password
		click_button 'Log In'
		expect(page).to have_content("Invalid email/password")
	end

	it "doesn't log in the user if password is incorrect" do
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: "notright"
		click_button 'Log In'
		expect(page).to have_content("Invalid email/password")
	end

	it "doesn't log in the user if password is incorrect" do
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: "notright"
		click_button 'Log In'
		expect(page).to have_content("Invalid email/password")
	end

	it "logs out the user" do
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: @user.password
		click_button 'Log In'
		click_link "LOG OUT"
		expect(page).to have_link "LOG IN"
	end


end
















