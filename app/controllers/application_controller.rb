require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :require_login

  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

	def require_login
    if !logged_in? 
      flash[:notice] = "You must be logged in to view the requested page."
      redirect_to login_path
    end
	end
end
