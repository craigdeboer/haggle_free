source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'normalize-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'figaro', '~> 1.1.0'
gem 'simple_form', '~> 3.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'responders'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem "paperclip", "~> 4.2"
gem "aws-sdk", '< 2.0'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
group :development do
    gem 'capistrano'
    gem 'capistrano-rvm'
    gem 'capistrano-rails'
end
group :test do 
	gem 'factory_girl_rails', '~> 4.5.0'
	gem 'capybara', '~> 2.4.4'
	gem 'selenium-webdriver', '~> 2.44.0'
	gem 'faker', '~> 1.4.3'
	gem 'chromedriver-helper'
	gem 'database_cleaner'
	gem 'launchy'
end

group :development, :test do
	gem 'rspec-rails', '~> 3.2.0'
	gem 'better_errors'
	gem 'binding_of_caller'
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

