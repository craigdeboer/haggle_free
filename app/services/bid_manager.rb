class BidManager
  
  def initialize(params)
    @associated_listing = Listing.find(params[:listing_id])
    @price = params[:price] if params[:price]
  end

  def price
    @price
  end

  def listing_sub_category
    @associated_listing.sub_category
  end

  def bids
    @bids = @associated_listing.bids.all
  end

  def new_bid
    @bid = @listing.bids.new
  end

  def listing_owner
    @listing_owner = User.find(@associated_listing.user_id)
  end

  def associated_listing_title
    @associated_listing.title
  end
  
  def listing_user_email
    listing_owner.email
  end
    
  def listing_reserve
    auction.reserve
  end

  def listing_show_reserve
    auction.show_reserve
  end

  def auction 
    @associated_listing.auction
  end

end
