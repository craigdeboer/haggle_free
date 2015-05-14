class Answer < ActiveRecord::Base
	belongs_to :question

	validates :answer, presence: true, length: { maximum: 1000 }
	validates :question_id, presence: true

end
