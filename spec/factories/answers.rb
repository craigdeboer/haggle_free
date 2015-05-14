FactoryGirl.define do

	factory :answer do
		association :question
		answer { Faker::Lorem.sentence(1) }
	end
end