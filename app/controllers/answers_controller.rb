class AnswersController < ApplicationController

	def new
		@listing = Listing.find(params[:listing_id])
		@question = Question.find(params[:question_id])
		@answer = @question.build_answer
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@answer = Answer.new(answer_params)
		if @answer.save
			flash[:success] = "Your answer has been sent to the questioner."
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

	def answer_params
		params.require(:answer).permit(:answer, :question_id)
	end

end