module SharedFilters
	extend ActiveSupport::Concern

	included do
		before_filter :clear_my_listings
	end

	def clear_my_listings
    session[:user_listings] = false
  end

end