class ImagesController < ApplicationController

	def index
		
	end

	def show
		@image = Image.find(params[:id])
		@image.ratio = params[:ratio]
	end

	def new
		@image = Image.new
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@image = Image.new(image_params)
		ratio = @image.picture_geometry if @image.picture_file_size <= 1048576
		@image.listing_id = params[:listing_id]
		if @image.save
			redirect_to listing_image_path(id: @image.id, ratio: ratio)
		else
			flash[:notice] = "If you need help decreasing the size of your file, google 'image optimization'"
			@image.errors[:picture_file_size].clear
			render 'new'
		end
	end

	def edit
		@image = Image.find(params[:id])
	end

	def update	
		@image = Image.find(params[:id])
		@image.update_attributes(crop_params)
    @image.picture.reprocess!  #crop the image and then save it.
    redirect_to listing_path(id: params[:listing_id])
	end

	def destroy
	end

	private

		def get_ratio(image)
			ratio = image.picture_geometry(:original).width / image.picture_geometry(:large).width
		end

		def image_params
			params.require(:image).permit(:picture)
		end

		def crop_params
			params.require(:image).permit(:x_value, :y_value, :width_value, :height_value)
		end
end
