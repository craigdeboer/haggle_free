module SharedFilters
	extend ActiveSupport::Concern

# Any before actions included in the block below will be inserted into the controller that includes this module.
	included do
		before_action :clear_my_listings, only: :index
	end

	def clear_my_listings
    session[:user_listings] = false
  end

  def require_admin
    if !admin?
      flash[:notice] = "You must be an admin user to access the requested page."
      redirect_to root_path
    end
  end

end
