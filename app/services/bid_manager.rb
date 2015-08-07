class BidManager
  
  def initialize(params)
    @listing = Listing.find(params[:listing_id])
    @price = params[:price] if params[:price]
  end

  def price
    @price
  end

  def listing
    @listing
  end

  def listing_sub_category
    @listing.sub_category
  end

  def bids
    @bids = @listing.bids.all
  end

  def new_bid
    @bid = @listing.bids.new
  end

  def listing_owner
    @listing_owner = User.find(@listing.user_id)
  end

  def listing_title
    @listing.title
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
    @listing.auction
  end

end
