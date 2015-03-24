require 'rails_helper'
require 'chromedriver'


describe "Category management" do

	before do 
		@category = Category.create(name: "Freebies")
		visit categories_path
	end

	it "adds a new category", :js => true  do		
		expect{ 
			click_button "Add Category"
			fill_in "Name", with: "Dogs"
			click_button "Create Category"
			expect(page).to have_content("Dogs")
		}.to change(Category, :count).by(1)
		
	end

	it "deletes a category", :js => true do
		expect{
			within "div#list-categories" do
				click_link("Delete", :match => :first)
			end
			page.driver.browser.switch_to.alert.accept
			expect(page).to_not have_content("Freebies")
		}.to change(Category, :count).by(-1)
		
	end



end
