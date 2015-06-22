class AnswersController < ApplicationController

	def new
	end

	def create
		@answer = question.build_answer(answer_params)
		if @answer.save
			UserMailer.answer_received(questioner.email, question.question, @answer.answer, listing.title).deliver_later
			flash[:success] = "Your answer has been sent to the questioner."
			redirect_to listing
		else 
			render 'new'	
		end
	end

	def edit
	end

	def update
		if answer.update_attributes(answer_params)
			redirect_to answer.question.listing, notice: "Your answer has been updated." 
		end
	end

private

	def answer_params
		params.require(:answer).permit(:answer, :question_id)
	end

	def question
		@question ||= Question.includes(:listing).find(params[:question_id])
	end
	helper_method :question

	def answer
		if params[:id]
			@answer ||= Answer.find(params[:id])
		else
			@answer = question.build_answer
		end
	end
	helper_method :answer

	def questioner
		@question.user
	end

	def listing
		question.listing
	end

end