module LoginMacros

	def set_user_session(user)
		session[:user_id] = user.id 
	end

	def log_in(user)
		visit root_path
		click_link "LOG IN"
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Log In'
	end

end