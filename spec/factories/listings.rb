FactoryGirl.define do

	factory :listing do
		association :user
		association :sub_category
		title { Faker::Lorem.sentence(3) }
		description { Faker::Lorem.paragraph(2) }
		sell_method "Auction"
	end

end