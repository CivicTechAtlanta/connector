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
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

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

group :development do
  gem 'spring-commands-rspec'
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
end

gem 'rails_12factor', group: :production
