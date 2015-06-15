module SharedFilters
	extend ActiveSupport::Concern

	included do
		before_action :clear_my_listings
	end

	def clear_my_listings
    session[:user_listings] = false
  end

end