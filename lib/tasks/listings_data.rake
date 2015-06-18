
namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do

		3.times do |n|
			category = Category.create!(name: "Category#{n}")
			3.times do |count|
				subcategory = category.sub_categories.create!(name: "Subcategory#{count}")
				create_the_listings(subcategory)
			end
		end
	end

	def create_the_listings(subcategory)
		20.times do |n|
			title = "#{subcategory.name} Item #{n}"
			description = "This #{title} is in fantastic condition!"
			user_id = [2, 3].sample
			sub_category_id = subcategory.id
			if n.even?
				sell_method = "Auction"
				reserve = rand(100..3000)
				show_reserve = [0, 1].sample
				end_date = DateTime.now + n
				Listing.create!(title: title, description: description, sell_method: sell_method, sub_category_id: sub_category_id, user_id: user_id, auction_attributes: {reserve: reserve, show_reserve: show_reserve, end_date: end_date} )
			else
				sell_method = "Price"
				start_price = rand(100..3000)
				price_decrement = start_price/20
				price_interval = [1, 2, 3].sample
				sale_pending = 0
				Listing.create!(title: title, description: description, sell_method: sell_method, sub_category_id: sub_category_id, user_id: user_id, price_fade_attributes: {start_price: start_price, price_decrement: price_decrement, price_interval: price_interval, sale_pending: sale_pending})
			end	
		end
	end
end