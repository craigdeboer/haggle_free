require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

	before do
		@craig = create(:user)
		@active_auction = create(:auction)
		@ended_auction = create(:auction, end_date: Date.today.to_time - 2.days)
		@active_price_fade = create(:price_fade)
		@ended_price_fade = create(:price_fade, price_interval: -1)
	end

  context "with a logged-in user" do

		before { allow(controller).to receive(:current_user) { @craig } }

		describe "GET #index" do
			it "assigns active listings to @listings" do
				get :index
				puts "active auction #{@active_auction.end_date}"
				puts "ended #{@ended_auction.end_date}"
				puts "active price #{@active_price_fade.end_date}"
				puts "ended #{@ended_price_fade.end_date}"
      	expect(assigns(:listings)).to match_array([@active_auction.listing, @active_price_fade.listing])
			end
		end 
	end
end
