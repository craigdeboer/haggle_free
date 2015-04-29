class Auction < ActiveRecord::Base
	belongs_to :listing

	scope :active, -> { where("auctions.end_date > ?", DateTime.now) }

 	validates :reserve, presence: true
	validates :end_date, presence: true

	before_save :set_end_date

private

	def set_end_date
		self.end_date = self.end_date.change(hour: Time.now.hour, min: Time.now.min)
	end

end
