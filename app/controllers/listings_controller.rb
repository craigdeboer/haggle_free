class ListingsController < ApplicationController

  skip_before_action :require_login, only: [:index, :subcategory, :category, :show] 
  before_action :set_my_listings, only: :user
  before_action :clear_my_listings, except: :user
  
  def index
    @listings = Listing.listings_select(params).page(params[:page]).per_page(10)  
  end

  def user
    @listings = Listing.user_listings(current_user).page(params[:page]).per_page(10)
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

  def set_my_listings
    session[:user_listings] = true
  end

  def clear_my_listings
    session[:user_listings] = false
  end

  def listing_owner
    if @listing.user != current_user
      flash[:notice] = "You may not edit another user's listing."
      redirect_to root_path
    end
  end

  def page_title
    @page_title ||= determine_listings_request
  end
  helper_method :page_title

  def determine_listings_request
    if params[:category_id]
      @page_title = Category.find(params[:category_id])
    elsif params[:sub_category_id]
      @page_title = SubCategory.includes(:category).find(params[:sub_category_id])
    elsif session[:user_listings]
      @page_title = "Here are your listings #{current_user.first_name}"
    else
      @page_title = "Recent Listings"
    end
  end

end
