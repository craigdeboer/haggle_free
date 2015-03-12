class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    @images = Image.all
  end

  def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
    @listings = @subcategory.listings.includes(:images).all.order(created_at: :desc)
  end

  def user
  end

  def show
    @listing = Listing.includes(:auction, :price_fade).find(params[:id])
    @images = @listing.images.all
  end

  def new
    @listing = User.find(params[:user_id]).listings.new
    @listing.build_auction
    @listing.build_price_fade
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.post_date = Date.today
    @listing.user_id = params[:user_id]
    if @listing.save
      flash[:success] = "New listing created."
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
    redirect_to listings_path
  end

  private

    def listing_params
      params.require(:listing).permit(:title, :description, :sell_method, :post_date, :sub_category_id, :user_id, auction_attributes: [:reserve, :show_reserve, :end_date], price_fade_attributes: [:start_price, :price_decrement, :price_interval])
    end

end
