class PriceFadePresenter

	def initialize(object, template)
		@price_fade = object
		@template = template
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

	def pricing_table
		html_class = "before-current-price"
		price_fade_hash.each do |key, value|
			if key == "Current Price"
				html_class = "current-price"
			elsif html_class == "current-price"
				html_class = "after-current-price"
			end
			key = key.strftime("%a %B %d") unless key == "Current Price"
			yield(key, value, html_class)
		end
		return
	end

  def get_price
    find_current_price
  end

  private

  def price_fade
    @price_fade
  end

  def price_decrement
    price_fade.price_decrement
  end

  def price_interval
    price_fade.price_interval
  end

	def price_fade_hash
		date_price_array = []
		start_date = price_fade.created_at.to_date
		start_price = price_fade.start_price
		current_price = find_current_price
		for i in 0..7
			date = start_date + (price_interval * i)
			price = start_price - (price_decrement * i)
			date = "Current Price" if price == current_price
			date_price_array << date << price
		end
		the_hash = Hash[*date_price_array]
	end

	def find_current_price
    current_price = price_fade.start_price - (number_of_intervals * price_decrement)
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
