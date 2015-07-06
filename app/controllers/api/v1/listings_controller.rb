module Api
  module V1
    class ListingsController < ApplicationController
      
      def index
        @listings = Listing.limit(10)
        render json: @listings
      end
    end
  end
end
