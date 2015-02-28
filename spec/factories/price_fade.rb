FactoryGirl.define do

	factory :price_fade do
		association :listing
		start_price "25.50"
		end_price "10.00"
		end_date Date.today.to_time + 7.days
	end
end