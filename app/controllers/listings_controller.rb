class ListingsController < ApplicationController

  skip_before_action :require_login, only: [:index, :subcategory, :show] 
  before_action :set_my_listings, only: :user
  before_action :clear_my_listings, except: :user
  
  def index
    @listings = Listing.active.order(created_at: :desc)
  end

  def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
    @listings = Listing.subcategory_listings(@subcategory)
  end

  def user
    @listings = Listing.user_listings(current_user)
  end

  def show
    @listing = Listing.includes(:auction, :price_fade, :sub_category, :images, :bids, :questions).find(params[:id])
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

  def set_my_listings
    session[:user_listings] = true
  end

  def clear_my_listings
    session[:user_listings] = false
  end

end
