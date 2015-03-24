class ImagesController < ApplicationController

	def index
	end

	def show
		@image = Image.find(params[:id])
	end

	def new
		@image = Image.new
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@image = Image.new(image_params)
		@image.listing_id = params[:listing_id]
		if @image.save
			redirect_to listing_image_path(id: @image.id)
		else
			render 'new'
		end
	end

	def edit
		@image = Image.find(params[:id])
	end

	def update	
		@image = Image.find(params[:id])
		ratio = get_ratio(@image)
		@image.update_attributes(crop_params)
    @image.x_value = (@image.x_value.to_i * ratio).round
    @image.y_value = (@image.y_value.to_i * ratio).round
    @image.height_value = (@image.height_value.to_i * ratio).round
    @image.width_value = (@image.width_value.to_i * ratio).round
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
			params.require(:image).permit(:picture, :main_image)
		end

		def crop_params
			params.require(:image).permit(:x_value, :y_value, :width_value, :height_value)
		end
end
