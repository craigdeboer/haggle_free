FactoryGirl.define do

	factory :auction do
		association :listing
		reserve "100"
		show_reserve true
		end_date Date.today.to_time + 7.days
	end
end