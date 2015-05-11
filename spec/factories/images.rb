FactoryGirl.define do

	factory :image do
		association :listing
		listing_id 45
		picture_file_name "cool_motorcycle.jpeg"
		picture_content_type "image/jpeg"
		picture_file_size "2490000"
	end
end