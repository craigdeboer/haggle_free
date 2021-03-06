class SessionsController < ApplicationController

	skip_before_action :require_login

	def new
	end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in(@user)
			remember(@user)
			redirect_back_or root_path
		else
			flash.now[:error] = "Invalid email/password combination."
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_path
	end

end
