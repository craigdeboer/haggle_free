FactoryGirl.define do

	factory :bid do
		association :user
		association :listing
		price '25.00'
	end
end