require 'rails_helper'
require 'chromedriver'

feature "Sub-category management" do

	before do
		log_in create(:user, admin: true)
		create_category "Sports"
		visit root_path
	end

	feature "Adding a new subcategory" do
		scenario "successfully", :js => true  do		
			create_subcategory "Football", "Sports"
			expect(page).to have_css "a", text: "Football"
		end
	end

	feature "Deleting a category" do
		scenario "successfully", :js => true do
			create_subcategory "Golf", "Sports"
			delete_subcategory "Golf"
			expect(page).to_not have_css "a", text: "Golf"
		end
	end


end

