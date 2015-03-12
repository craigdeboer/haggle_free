module ListingsHelper

	def current_price
		a = 25.50
	end

	def price_fade_hash(price_fade)
		date_price_array = []
		current_time = DateTime.now
		found_current_price = 0
		for i in 0..7
			date = price_fade.created_at.to_date + (price_fade.price_interval * i)
			date = (date.to_time + (60*60*22)).to_datetime
			next_date = date + price_fade.price_interval
			price = (price_fade.start_price - (price_fade.price_decrement * i))
			if found_current_price == 0
				if (date < current_time && next_date > current_time) || price_fade.created_at.to_date == Date.today
					date_price_array << "Current Price" << "$#{sprintf('%.2f', price)}"
					found_current_price = 1
				end
			elsif date > current_time
					date_price_array << date.to_date << "$#{sprintf('%.2f', price)}"
			end
		end
		the_hash = Hash[*date_price_array]
	end

end
