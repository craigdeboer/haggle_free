require 'rails_helper'


describe "User management" do

	it "saves a new user" do
		visit root_path
		click_link "Sign Up"
		fill_in "First name", with: "Jack"
		fill_in "Last name", with: "Jones"
		fill_in "User name", with: "Jackj"
		fill_in "Email", with: "jack@gmail.com"
		expect{ click_button "Create User" }.to change(User, :count).by(1)
	end

end