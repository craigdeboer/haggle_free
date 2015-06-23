module SharedFilters
	extend ActiveSupport::Concern

	included do
		before_action :clear_my_listings
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