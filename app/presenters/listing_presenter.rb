class ListingPresenter

	def initialize(object, template)
		@listing = object
		@template = template
	end

	def h
		@template
	end

	#Listing index methods

	def thumbnail
		h.link_to h.image_tag(@listing.images.first.picture.url(:thumb)), h.listing_path(@listing), class: "listing-image-display" if @listing.images.any?
	end

	def title
		h.link_to @listing.title, h.listing_path(@listing)
	end

	def sale_pending_message
		h.content_tag :li, "SALE PENDING", class: "sale-pending" if sale_pending?
	end

	def bids_or_offers
		if auction?
			h.content_tag :span, "Bids: ", class: "attribute"
		else
			h.content_tag :span, "Offers: ", class: "attribute"
		end	
	end

	#Listing show methods

  def sale_pending_information
    h.content_tag :div, "* There is a sale pending on this item and #{@listing.bids_count - 1} of 2 allowed backup offers.", class: "sale-pending" if sale_pending? 
 	end

	def large_image 
		h.image_tag @listing.images.first.picture.url(:large), class: "main-image-display" if images?
	end

	def thumbnails
		h.render 'thumbnail_display' if images?
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

	def sell_method_details
		if auction?
      h.render 'auction_details', auction: @listing.auction, listing: @listing
		else
			h.render 'price_fade_details', price_fade: @listing.price_fade, listing: @listing
		end
	end

private

	def price_fade
		@listing.price_fade
	end


	def auction?
	  @listing.sell_method == "Auction"
	end

	def images?
		!@listing.images.empty?
	end

				
	def sale_pending?
		if @listing.sell_method == "Price"
			price_fade.sale_pending
		else
			false
		end
	end
end

