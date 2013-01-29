source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'thin'

gem 'jquery-rails'
gem 'backbone-on-rails'

# Authentication
gem 'devise', '~> 2.1.2'
gem 'devise_invitable'

gem "simple_form"

gem 'json_builder'
gem 'jbuilder'

gem 'geocoder'

group :development do
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml'
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'less-rails' # Required by the twitter-bootstrap-rails....
  gem "twitter-bootstrap-rails"
  # gem 'bootstrap-sass'

  gem 'haml_coffee_assets'
  gem 'execjs'
  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem "sqlite3"
  gem 'poltergeist'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'rspec-rails'
  gem 'email_spec'
end