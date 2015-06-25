class PriceFadePresenter

	def initialize(object, template)
		@price_fade = object
		@template = template
	end

  def price_fade
    @price_fade
  end

  def price_decrement
    price_fade.price_decrement
  end

  def price_interval
    price_fade.price_interval
  end

	def h
		@template
	end

  def current_price
		h.content_tag :span, h.number_to_currency(find_current_price) 
  end

  def next_price_display
    h.content_tag :span, next_price + " on " + next_date.strftime("%B %d")  
  end

  private


	def find_current_price
    current_price = price_fade.start_price - (number_of_intervals * price_interval)
	end

	def next_price
		h.number_to_currency(find_current_price - price_decrement)
	end

  def hours_since_listing_creation
    (Time.now - price_fade.created_at)/3600
  end

  def hours_in_interval 
    price_interval * 24
  end

	def next_date
		price_fade.created_at + (price_interval * (number_of_intervals + 1)).days
	end
  
  def number_of_intervals
    (hours_since_listing_creation/hours_in_interval).floor
  end
end
