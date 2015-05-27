require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	before do
		@user = create(:user)
	end

	describe "GET #new" do
		it "renders the new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe "POST #create" do
		context "with a valid user name and password" do
			before { post :create, session:{email: @user.email, password: @user.password} }
			it "assigns the correct user to @user" do
				expect(assigns(:user)).to eq @user
			end
			it "saves the user's id in a session variable" do
				expect(session[:user_id]).to eq @user.id
			end
		end	
		context "with invalid user name" do
			it "redirects to the login page" do
				post :create, session:{email: "someemail@example.com", password: @user.password }
				expect(response).to render_template :new
			end
		end
		context "with invalid password" do
			it "redirects to the login page" do
				post :create, session:{email: @user.email, password: "wrongpassword" }
				expect(response).to render_template :new
			end
		end
	end

	describe "DELETE #destroy" do
		it "deletes the user's id from session[:user_id]" do
			allow(controller).to receive(:current_user) { @user }
			delete :destroy
			expect(session[:user_id]).to eq nil
		end
	end

end
