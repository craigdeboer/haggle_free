class ImagesController < ApplicationController

	before_action :find_listing, only: [:new, :create]
	before_action :find_image, only: [:edit, :update, :destroy]
	before_action :listing_owner, only: :new
	before_action :image_owner, only: :edit

	def index
	end

	def new
		@image = Image.new
	end

	def create
		@image = Image.new(image_params)
		if @image.save
			redirect_to edit_image_path(@image, ratio: @image.ratio)
		else
			flash[:notice] = "If you need help decreasing the size of your file, google 'image optimization'"
			@image.errors[:picture_file_size].clear
			render 'new'
		end
	end

	def edit
		@image.ratio = params[:ratio]
	end

	def update	
		@image.update_attributes(crop_params)
    @image.picture.reprocess!  #crop the image and then save it.
    redirect_to new_listing_image_path(@image.listing)
	end

	def destroy
		@image.destroy
		redirect_to new_listing_image_path(@image.listing)
	end

	private

		def get_ratio(image)
			ratio = image.picture_geometry(:original).width / image.picture_geometry(:large).width
		end

		def image_params
			params.require(:image).permit(:picture).merge(listing_id: params[:listing_id])
		end

		def crop_params
			params.require(:image).permit(:x_value, :y_value, :width_value, :height_value)
		end

		def find_listing
			@listing = Listing.includes(:images).find(params[:listing_id])
		end

		def find_image
		  @image = Image.find(params[:id])
		end

		def listing_owner
			if current_user.id != @listing.user_id
				flash[:notice] = "You are trying to add an image to a listing that isn't yours."
				redirect_to root_path
			end
		end

		def image_owner
			if current_user.id != @image.listing.user_id
				flash[:notice] = "You are trying to edit an image that doesn't belong to you."
				redirect_to root_path
			end
		end
	
end
