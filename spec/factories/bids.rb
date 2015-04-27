FactoryGirl.define do

	factory :bid do
		association :user
		association :listing
		price '125.00'
	end
end