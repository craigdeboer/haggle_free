class AnswersController < ApplicationController

	def new
		# @question = Question.includes(:listing).find(params[:question_id])
		# @answer = @question.build_answer
	end

	def create
		# @question = Question.find(params[:question_id])
		@answer = question.build_answer(answer_params)
		if @answer.save
			UserMailer.answer_received(@answer.question.user.email, @answer.question.question, @answer.answer, question.listing.title).deliver_later
			flash[:success] = "Your answer has been sent to the questioner."
			redirect_to question.listing
		else 
			render 'new'	
		end
	end

	def edit
		# @answer = Answer.find(params[:id])
	end

	def update
		# @answer = Answer.find(params[:id])
		answer.update_attributes(answer_params)
		redirect_to answer.question.listing
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

end