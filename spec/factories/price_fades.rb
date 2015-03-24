FactoryGirl.define do

	factory :price_fade do
		association :listing
		start_price "25.50"
		price_interval 2
		price_decrement "1.00"
	end
end