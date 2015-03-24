class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    @images = Image.all
  end

  def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
    @listings = @subcategory.listings.includes(:images, :auction, :price_fade, :user).order(created_at: :desc)
  end

  def user
    @user = current_user
    @listings = @user.listings.includes(:auction, :price_fade, :bids).all
  end

  def show
    @listing = Listing.includes(:auction, :price_fade, :sub_category).find(params[:id])
    @images = @listing.images.all
    @bids = @listing.bids.all
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
      redirect_to @listing
    else
      render 'new'
    end
  end

  def edit
  end

  def update
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
