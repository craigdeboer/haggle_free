class Image < ActiveRecord::Base

  attr_accessor :x_value, :y_value, :width_value, :height_value, :ratio

  has_attached_file :picture, 
    styles: { thumb: ["140>", :jpg], large: ['600>', :jpg] }, 
    convert_options: { thumb: '-quality 30 -strip', large: '-quality 70 -strip' },
    processors: [:cropper]
                              
                                                          
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 2.5.megabyte
  validates :listing_id, presence: true
  belongs_to :listing

  around_create :get_ratio

  def cropping?
    !x_value.blank? && !y_value.blank?
  end

  def picture_geometry
    original_width = Paperclip::Geometry.from_file(self.picture.queued_for_write[:original]).width
    large_width = Paperclip::Geometry.from_file(self.picture.queued_for_write[:large]).width
    if original_width <= 600
      ratio = 1
    else
      ratio = original_width / large_width
    end
  end

  def get_ratio
    ratio = self.picture_geometry if self.picture_file_size < 2.5.megabyte
    yield
    self.ratio = ratio
  end
  
end
