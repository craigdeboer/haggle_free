FactoryGirl.define do

	factory :expired_listing do
		association :user
		association :sub_category
		original_listing_id 22
		title { Faker::Lorem.sentence(3) }
		number_of_bids 3
		highest_bid 500.00
		end_date DateTime.now + 7.days
		sold false
	end
end