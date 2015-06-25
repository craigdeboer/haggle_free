class AuctionPresenter
  
	def initialize(object, template)
		@auction = object
		@template = template
	end

	def h
		@template
	end

  def reserve
		if show_reserve?
			h.content_tag :span, h.number_to_currency(@auction.reserve)
		elsif reserve?
			"Yes, but it's hidden." 
		else
			"No Reserve"
		end
	end

  private

	def reserve?
		@auction.reserve != 0
	end
  
  def show_reserve?
    @auction.show_reserve
  end
end
