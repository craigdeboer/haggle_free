module SubcategoryMacros

	def create_subcategory(name, category)
		click_on "Add Sub-Category For #{category}"
		wait_for_ajax
		fill_in "Name", with: name
		click_button "Add Sub-Category"
	end

	def delete_subcategory(name)
		click_on "Delete #{name}"
		page.driver.browser.switch_to.alert.accept
		wait_for_ajax
	end

end