module ListingsHelper

	def find_current_price(price_fade)
		start_date = price_fade.created_at.beginning_of_day + 21.hours
		current_time = DateTime.now
		interval = price_fade.price_interval
		for i in 0..7
			date = start_date + (interval * i).days
			next_date = date + interval.days
			if current_time < start_date 
				current_price = price_fade.start_price
			elsif (current_time >= date) && (current_time < next_date)
				current_price = price_fade.start_price - (price_fade.price_decrement * i)
			end
		end
		current_price
	end

	def price_fade_hash(price_fade)
		date_price_array = []
		start_date = price_fade.created_at.beginning_of_day + 21.hours
		start_price = price_fade.start_price
		current_price = find_current_price(price_fade)
		for i in 0..7
			date = start_date.to_date + (price_fade.price_interval * i)
			price = start_price - (price_fade.price_decrement * i)
			date = "Current Price" if current_price == price
			date_price_array << date << "$#{sprintf('%.2f', price)}"
		end
		the_hash = Hash[*date_price_array]
	end

	def count_bids(bids, price)
		counter = 0
		bids.each do |bid|
			if bid.price == price.remove("$").to_f
				counter += 1
			end
		end
		counter
	end

	def show_reserve(auction)
		if auction.reserve > 0
			reserve = "$#{auction.reserve}" if auction.show_reserve
 			reserve = "Yes, but hidden." if !auction.show_reserve
 		else
 			reserve = "No Reserve."
 		end
 		reserve
	end

end
