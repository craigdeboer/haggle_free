class Question < ActiveRecord::Base

	belongs_to :user
	belongs_to :listing

	has_one :answer, dependent: :destroy

	validates :question, presence: true, length: { maximum: 499 }
	validates :user_id, presence: true
	validates :listing_id, presence: true
	
end
