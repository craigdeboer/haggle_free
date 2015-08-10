class ListingsController < ApplicationController

  include SharedFilters
  skip_before_action :require_login, only: [:index, :show] 
  
  def index
    @listings = Listing.recent_listings.page(params[:page]).per_page(10) 
  end

  def show
    @listing = Listing.includes(:auction, :price_fade, :sub_category, :images, :bids, questions: :answer).find(params[:id])
  end

  def new
    @listing = Listing.new
    @listing.build_auction
    @listing.build_price_fade
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      flash[:success] = "Your new listing has been created. Add some pictures."
      redirect_to new_listing_image_path(@listing)
    else
      render 'new'
    end
  end

  def edit
    @listing = Listing.includes(:images, :price_fade, :auction, :sub_category).find(params[:id])
    listing_owner
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update_attributes(listing_params)
    redirect_to @listing
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to user_listings_path
  end

private

  def listing_params
    params.require(:listing).permit(:title, :description, :sell_method, :sub_category_id, :user_id, auction_attributes: [:reserve, :show_reserve, :end_date], price_fade_attributes: [:start_price, :price_decrement, :price_interval]).merge(user_id: current_user.id)
  end
  
  def page_params
    (params[:page]).per_page(10)
  end 

  def find_category
    @category = Category.find(params[:category_id])
  end

  def listing_owner
    if @listing.user != current_user
      flash[:notice] = "You may not edit another user's listing."
      redirect_to root_path
    end
  end

end
