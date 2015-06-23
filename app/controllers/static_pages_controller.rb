class StaticPagesController < ApplicationController

	layout "welcome"

	skip_before_action :require_login

	def index
		redirect_to sub_categories_path if logged_in?
	end

end