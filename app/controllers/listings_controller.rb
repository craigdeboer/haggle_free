class ListingsController < ApplicationController
  def index
  end

  def subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
    @listings = @subcategory.listings.all.order(created_at: :desc)
    render 'index'
  end

  def user
  end

  def show
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
  end

  private

    def listing_params
      params.require(:listing).permit(:title, :description, :sell_method, :post_date, :sub_category_id, :user_id, auction_attributes: [:reserve, :show_reserve, :end_date], price_fade_attributes: [:start_price, :price_decrement, :price_interval])
    end

end
