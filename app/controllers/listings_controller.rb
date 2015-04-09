class ListingsController < ApplicationController
  
  def index
    @listings = Listing.includes(:images).all
  end

  def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
    @listings = Listing.subcategory_listings(@subcategory)
  end

  def user
    @listings = Listing.user_listings(current_user)
  end

  def show
    @listing = Listing.includes(:auction, :price_fade, :sub_category, :images, :bids).find(params[:id])
  end

  def new
    @user = current_user
    @listing = @user.listings.new
    @listing.build_auction
    @listing.build_price_fade
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.post_date = Date.today
    @listing.user_id = current_user.id
    if @listing.save
      flash[:success] = "Here is your new listing."
      redirect_to new_listing_image_path(@listing)
    else
      render 'new'
    end
  end

  def edit
    @listing = Listing.includes(:images, :price_fade, :auction, :sub_category).find(params[:id])
    
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update_attributes(listing_params)
    redirect_to @listing
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to sub_category_listings_path(sub_category_id: @listing.sub_category_id)
  end

  private

    def listing_params
      params.require(:listing).permit(:title, :description, :sell_method, :post_date, :sub_category_id, :user_id, auction_attributes: [:reserve, :show_reserve, :end_date], price_fade_attributes: [:start_price, :price_decrement, :price_interval])
    end

end
