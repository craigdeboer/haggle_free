# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "#{path}/log/cron_log.log"
#
every '0,15,30,45 8-22 * * *' do
  command "RAILS_ENV=production bin/delayed_job start --exit-on-complete"
end

every :hour do
	runner "Listing.recently_ended"
end

every :day, at: '12am' do
	runner "ExpiredListing.purge"
end


# Learn more: http://github.com/javan/whenever
