class AnswersController < ApplicationController

	def new 
    @answer_builder = AnswerBuilder.new(params[:question_id])
	end

	def create
    @answer_creator = AnswerCreator.new(params[:question_id])
		@answer = @answer_creator.answer(answer_params)
		if @answer.save
			UserMailer.answer_received(@answer_creator.questioner_email, @answer_creator.question, @answer.answer, @answer_creator.listing_title).deliver_later
			flash[:success] = "Your answer has been sent to the questioner."
			redirect_to @answer_creator.listing
		else 
			render 'new'	
		end
	end

  def edit
		@answer = Answer.find(params[:id])
	end

	def update
    @answer = Answer.find(params[:id])
		if @answer.update_attributes(answer_params)
			redirect_to associated_listing(@answer), notice: "Your answer has been updated." 
    else
      render 'edit'
		end
	end

private

	def answer_params
		params.require(:answer).permit(:answer, :question_id)
	end

end
