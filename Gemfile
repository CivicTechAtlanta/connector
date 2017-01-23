source 'https://rubygems.org'

# ruby
ruby '2.1.2'

# Rails
gem 'rails', '4.1.9'

# Database
gem 'pg'
gem 'sucker_punch', '~> 1.0'

# Model
gem 'acts_as_commentable'
gem 'acts-as-taggable-on', '~> 3.4'

# Login
gem 'devise'
gem 'omniauth-facebook', '2.0.1'
gem 'omniauth', '1.2.2'
gem 'omniauth-oauth2', '1.3.1'

# Assets pipeline
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'redcarpet'

# Time zone
gem 'tzinfo-data'

# Environment
gem 'dotenv-rails'

# App server
gem 'puma'
gem 'foreman'

#emailing
gem 'premailer-rails'
gem 'nokogiri'

# scraping meetup events
gem 'icalendar'
gem 'recaptcha', require: 'recaptcha/rails'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
end

gem 'rails_12factor', group: :production
