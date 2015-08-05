class AnswerCreator

  def initialize(question_id)
    @question = Question.includes(:listing).find(question_id)
  end

  def new_answer
    @question.build_answer
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

