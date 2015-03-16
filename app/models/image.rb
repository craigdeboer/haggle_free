class Image < ActiveRecord::Base

	attr_accessor :x_value, :y_value, :width_value, :height_value

	has_attached_file :picture, styles: { thumb: "100x100#", large: ['600>', :jpg, quality: 70] }, processors: [:cropper]
	validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than=>1.megabyte
  validates :listing_id, presence: true
	belongs_to :listing

	def cropping?
    !x_value.blank? && !y_value.blank?
  end

  def picture_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
  end
end