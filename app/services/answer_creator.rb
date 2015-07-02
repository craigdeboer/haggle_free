class AnswerCreator

  def initialize(params)
    @question = Question.find(params[:question_id])
  end

  def answer(answer_params)
    @question.build_answer(answer_params)
  end

  def questioner_email
    questioner.email
  end
  
  def question
    @question.question
  end

  def listing_title
    listing.title
  end

  def listing
    @question.listing
  end

private

  def questioner
    @question.user
  end

end

