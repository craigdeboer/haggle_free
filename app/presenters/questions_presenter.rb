class QuestionsPresenter

  def initialize(questions, listing_owner, template)
    @listing_owner = listing_owner
    @questions = questions
    @template = template
  end

  def h
    @template
  end

  def q_and_a
    @questions.each do |question|
      user_question = question.question
        if question.answer
          answer = question.answer.answer 
          edit_info = edit_link(question)
        else
          answer = answer_link(question)
          edit_info = ''
        end 
        yield(user_question, delete_link(question), answer, edit_info,)
    end
    return
  end

private

  def listing_owner?
    h.current_user == @listing_owner
  end

  def email_sent?(question)
    question.created_at < 15.minutes.ago
  end

  def delete_link(question)
    if listing_owner? && email_sent?(question)
      h.link_to "Delete Question", h.question_path(question), method: :delete, data: {confirm: "Are you sure?"}, class: "delete-link"
    else
      ''
    end
  end

  def the_answer(question)
    question.answer
  end

  def edit_link(question)
    h.link_to "Edit Answer", h.edit_answer_path(question.answer), class: "button-normal" 
  end

  def answer_link(question)
    answer = h.link_to "Answer Question", h.new_question_answer_path(question), class: "button-normal"
  end
end
