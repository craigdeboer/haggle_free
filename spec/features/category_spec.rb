require 'rails_helper'
require 'chromedriver'


describe "Category management" do

	before do 
		@category = Category.create(name: "Freebies")
		visit categories_path
	end

	it "adds a new category", :js => true  do		
		click_link "Category"
		fill_in "Name", with: "Dogs"
		count = Category.count
		click_button "Create Category"
		expect(page).to have_content("successfully")
		expect(Category.count).to eq(count + 1)
	end

	it "deletes a category", :js => true do
		count = Category.count
		within "div#list-categories" do
			click_link("Delete", :match => :first)
		end
		page.driver.browser.switch_to.alert.accept
		expect(page).to have_content("successfully")
		expect(Category.count).to eq(count - 1)
	end



end
