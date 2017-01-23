source 'https://rubygems.org'

# ruby
ruby '2.3.3'

# Rails
gem 'rails', '~> 4.2'

# Database
gem 'pg'
gem 'sucker_punch'

# Model
gem 'acts_as_commentable'
gem 'acts-as-taggable-on'

# Login
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth'
gem 'omniauth-oauth2'

# Assets pipeline
gem 'sass-rails'
gem 'uglifier'
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
end

gem 'rails_12factor', group: :production
