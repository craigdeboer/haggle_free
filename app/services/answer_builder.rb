class AnswerBuilder

  def initialize(question_id)
    @question = Question.includes(:listing).find(question_id) 
  end

  def answer
    @question.build_answer
  end

  def associated_question 
    @question.question
  end

  def associated_listing_title
    listing.title
  end

private

  def listing
    @question.listing
  end
end

