module UsersHelper

	def is_admin(user)
		if user.admin
			admin = "Yes"
		else
			admin = "No"
		end
	end
end
