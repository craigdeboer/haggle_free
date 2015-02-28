FactoryGirl.define do

	factory :listing do
		association :user
		association :sub_category
		title { Faker::Lorem.words(4) }
		description { Faker::Lorem.paragraph(3) }
		sell_method "auction"
		post_date Date.today
	end
end