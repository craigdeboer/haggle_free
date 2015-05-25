require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

	before do
		@user = create(:user)
		@listing = create(:auction_listing, auction_attributes:(attributes_for(:auction, listing: @listing)))
		@question = create(:question, listing: @listing)
	end

	context "with a logged in user" do

		before { allow(controller).to receive(:current_user) { @user } }

		describe "GET #new" do
			before { get :new, question_id: @question.id }
			it "assigns a new answer with the correct associated question to @answer" do
				expect(assigns(:answer)).to be_a_new(Answer).with(question_id: @question.id)
			end
			it "renders the correct view" do
				expect(response).to render_template :new
			end
		end

		describe "POST #create" do
			context "with valid attributes" do
				it "saves the question in the database" do
					expect{
						post :create, question_id: @question.id, answer: attributes_for(:answer)
					}.to change(Answer, :count).by(1)
				end
			end

		end

		describe "GET #edit" do
			it "assigns the correct answer to @answer" do
				@answer = create(:answer, question: @question)
				get :edit, id: @answer.id
				expect(assigns(:answer)).to eq @answer
			end
		end

		describe "POST #update" do
			before do
			  @answer = create(:answer, question: @question)
			  patch :update, id: @answer.id, answer:{answer: "Yes, it is."}
			end
			it "assigns the correct answer to @answer" do
				expect(assigns(:answer)).to eq @answer
			end
			it "changes the attribute" do
				@answer.reload
				expect(@answer.answer).to eq "Yes, it is."
			end
			it "redirects to the listing show page" do
				expect(response).to redirect_to @listing
			end
		end
	end

end