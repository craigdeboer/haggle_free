FactoryGirl.define do

	factory :question do
		association :user
		association :listing
		question { Faker::Lorem.sentence(1) }
	end
end