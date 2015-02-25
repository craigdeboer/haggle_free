require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    

  describe "GET #index" do
    it "assigns all Users to @users" do

    end
  end

  describe "GET #show" do
  end

  describe "GET #new" do
    before { get :new }
    it "assigns a User.new to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end
    it "render the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before do
      @user = {first_name: "Peter", last_name: "Puck", 
                         user_name: "PeterP", email: "peterp@gmail.com",
                         password: "foobar", password_confirmation: "foobar"}
    end

    it "saves the new user to the database" do
      expect{ post :create, user: @user }.to change(User, :count).by(1)
    end

    
  end

  describe "GET #edit" do
    
  end

  describe "GET #update" do
    
  end

  describe "DELETE #destroy" do
    
  end

end
