FactoryGirl.define do

	factory :listing do
		association :user
		association :sub_category
		title { Faker::Lorem.sentence(3) }
		description { Faker::Lorem.paragraph(2) }

		factory :auction_listing do
			sell_method "Auction"
		end

		factory :price_fade_listing do
			sell_method "Price"
		end
	
	end

end