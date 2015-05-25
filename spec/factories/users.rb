FactoryGirl.define do

	factory :user do
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		sequence(:user_name) { |n| "username#{n}" }
		email { Faker::Internet.email }
		password "foobar"
		password_confirmation "foobar"
		admin false

		factory :admin do
			admin true
		end
	end
end