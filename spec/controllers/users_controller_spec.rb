require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user1 = create(:admin)
    @user2 = create(:user)
  end
    
  context "with a logged in user" do
    before { allow(controller).to receive(:current_user) { @user1 } }
    describe "GET #index" do
      it "assigns all Users to @users" do
        get :index
        expect(assigns(:users)).to match_array([@user1, @user2])
      end
    end

    describe "GET #show" do
    end

    describe "GET #new" do
      before { get :new }
      it "assigns a User.new to @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do

      it "saves the new user to the database" do
        expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end

      
    end

    describe "GET #edit" do
      before { get :edit, id: @user1.id }
      it "assigns an existing user to @user" do
        expect(assigns(:user)).to eq @user1
      end
      it "renders the new template" do
        expect(response).to render_template :edit
      end
      
    end

    describe "GET #update" do
      before do
        patch :update, id: @user1.id, user: attributes_for(:user, first_name: "Larry", last_name: "Bird")
      end
      it "assigns the correct user to @user" do
        expect(assigns(:user)).to eq(@user1)
      end
      it "changes the user's attributes" do
        @user1.reload
        expect(@user1.first_name).to eq("Larry")
        expect(@user1.last_name).to eq("Bird")
      end
    end

    describe "DELETE #destroy" do
      it "deletes the contact" do
        expect{ delete :destroy, id: @user2 }.to change(User, :count).by(-1)
      end
    end
  end
end
