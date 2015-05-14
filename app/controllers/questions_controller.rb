class QuestionsController < ApplicationController

	def new
		@listing = Listing.find(params[:listing_id])
		@question = Question.new
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@question = Question.new(question_params)
		if @question.save
			UserMailer.question_received(@listing.user, @question.question, @listing).deliver_later
			flash[:success] = "Your question has been sent to the seller."
			redirect_to listing_path(@listing)
		else 
			render 'new'	
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

private

	def question_params
		params.require(:question).permit(:question).merge(user_id: current_user.id, listing_id: params[:listing_id])
	end

end