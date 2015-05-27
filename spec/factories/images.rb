FactoryGirl.define do

	factory :image do
		association :listing
		picture_file_name "cool_motorcycle.jpeg"
		picture_content_type "image/jpeg"
		picture_file_size "2300000"
	end
end