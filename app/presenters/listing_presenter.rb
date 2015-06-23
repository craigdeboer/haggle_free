class ListingPresenter

	def initialize(object, template)
		@listing = object
		@template = template
	end

	def h
		@template
	end

	def thumbnail
		h.link_to h.image_tag(@listing.images.first.picture.url(:thumb)), h.listing_path(@listing), class: "listing-image-display" if @listing.images.any?
	end

	def title
		h.link_to @listing.title, h.listing_path(@listing)
	end

	def sale_pending_message
		h.content_tag :li, "SALE PENDING", class: "sale-pending" if sale_pending?
	end

	def sale_pending_information
		if sale_pending?
			h.content_tag :div, "There is a sale pending on this item and #{@listing.bids_count - 1} of the allowed 2 backup offers."
		end
	end

	def bids_or_offers
		if auction?
			attribute_name = h.content_tag :span, "Bids: ", class: "attribute"
			value = h.content_tag :span, @listing.bids_count.to_s 
		else
			attribute_name = h.content_tag :span, "Offers: ", class: "attribute"
			value = h.content_tag :span, "#{h.pluralize(@listing.bids_count, 'offer')} to buy." 
		end	
		yield(attribute_name, value)
	end

	def reserve_or_current_price
		if auction?
			attribute_name = "Reserve: "
			value = reserve
		else
			attribute_name = "Current Price: "
			value = h.number_to_currency(find_current_price) 
		end
		yield(attribute_name, value)
	end

	def end_date_or_next_price
		if auction? 
			attribute_name = h.content_tag :span, "End Date: ", class: "attribute" 
			value = @listing.end_date.strftime("%A, %B %-d") 
		elsif number_of_intervals != 7
			attribute_name = h.content_tag :span, "Next Price: ", class: "attribute" 
			value = h.content_tag :span, next_price + " on " + next_date.strftime("%B %d")
		else
			attribute_name = h.content_tag :span, "Next Price: ", class: "attribute" 
			value = "This auction has recently ended."
		end
		yield(attribute_name, value)
	end

	def delete_listing
		h.button_to "Delete", h.listing_path(@listing), method: :delete, data: { confirm: "Are you sure?" }, class: "delete-button" if @listing.user == h.current_user
	end

	def edit_listing
		h.button_to "Edit", h.edit_listing_path(@listing), method: :get, class: "button-normal" if @listing.user == h.current_user
	end

	def add_images
		h.button_to "Add Pictures", h.new_listing_image_path(@listing), method: :get, class: "button-normal" if @listing.user == h.current_user
	end

	#Individual Listing Methods

	def large_image 
		h.image_tag @listing.images.first.picture.url(:large), class: "main-image-display" if images?
	end

	def thumbnails
		h.render 'thumbnail_display' if images?
	end

	def q_and_a
		if @listing.questions.any?
			@listing.questions.each do |question|
				if question.answer != nil
					user_question = question.question
					answer = question.answer.answer
					delete_link = h.link_to "Delete Question", h.question_path(question), method: :delete, data: {confirm: "Are you sure?"}, class: "delete-link" if (@listing.user == h.current_user) && (question.answer.created_at < 15.minutes.ago)
					edit_link = h.link_to "Edit Answer", h.edit_answer_path(question.answer), class: "button-normal" if @listing.user == h.current_user
				else
					if @listing.user == h.current_user
						delete_link = h.link_to "Delete Question", h.question_path(question), method: :delete, data: {confirm: "Are you sure?"}, class: "delete-link"
						user_question = question.question
						answer = h.link_to "Answer Question", h.new_question_answer_path(question), class: "button-normal"
					else
						user_question = ""
						answer = ""
						delete_link = ""
						edit_link = ""
					end
				end 
				yield(user_question, delete_link, answer, edit_link)
			end
		end
		return
	end

	def sell_method_details
		if auction?
			h.render 'auction_details'
		else
			h.render 'price_fade_details'
		end
	end

	def get_price
		find_current_price
	end

	#Auction details partial method

	def reserve
		if show_reserve?
			h.number_to_currency(@listing.auction.reserve)
		elsif reserve?
			"Yes, but it's hidden." 
		else
			"No Reserve"
		end
	end

	#Price fade details partial methods

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

private

	def find_current_price
		start_date = price_fade.created_at
		current_time = DateTime.now
		interval = price_fade.price_interval
		current_price = 1000 if current_time > (start_date + (interval * 7).days)
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

	def price_fade
		@listing.price_fade
	end

	def next_price
		h.number_to_currency(find_current_price - (price_fade.price_decrement))
	end

	def number_of_intervals
		(price_fade.start_price - find_current_price)/price_fade.price_decrement
	end
	
	def next_date
		price_fade.created_at + (price_fade.price_interval * (number_of_intervals + 1)).days
	end

	def auction?
	  @listing.sell_method == "Auction"
	end

	def images?
		!@listing.images.empty?
	end

	def reserve?
		@listing.auction.reserve != 0
	end

	def show_reserve?
		@listing.auction.show_reserve
	end

	def price_fade_hash
		date_price_array = []
		start_date = price_fade.created_at
		start_price = price_fade.start_price
		current_price = find_current_price
		for i in 0..7
			date = start_date.to_date + (price_fade.price_interval * i)
			price = start_price - (price_fade.price_decrement * i)
			date = "Current Price" if current_price == price
			date_price_array << date << price
		end
		the_hash = Hash[*date_price_array]
	end
				
	def sale_pending?
		if @listing.sell_method == "Price"
			price_fade.sale_pending
		else
			false
		end
	end
end











