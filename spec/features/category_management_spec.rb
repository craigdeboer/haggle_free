require 'rails_helper'
require 'chromedriver'


feature "Adding a new category" do
	scenario "successfully", :js => true  do		
		create_category "Dogs"
		expect(page).to have_content "Dogs"
	end
end

feature "Deleting a category" do
	scenario "successfully", :js => true do
		create_category "Sports"
		delete_category
		expect(page).to_not have_content "Sports"
	end
end