class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in(@user)
			redirect_to root_path
		else
			flash.now[:error] = "Your email/password combination was not recognized"
			render 'new'
		end
	end

	def destroy
		session.delete(:user_id)
		@current_user = nil
		redirect_to root_path
	end

end
