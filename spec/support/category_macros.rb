module CategoryMacros

	def create_category(name)
		visit categories_path
		click_button "Add Category"
		fill_in "Name", with: name
		click_button "Create Category"
		wait_for_ajax
	end

	def delete_category
		click_link("Delete", :match => :first)
		page.driver.browser.switch_to.alert.accept
		wait_for_ajax
	end

end