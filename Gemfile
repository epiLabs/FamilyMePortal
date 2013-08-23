source 'https://rubygems.org'

gem 'rails', "~> 3.2.14"
gem 'pg'
gem 'mysql2'
gem 'thin'

# Authentication
gem 'devise'

gem "simple_form"

gem 'json_builder'

gem 'geocoder'

gem 'gravtastic'

gem 'omniauth'
gem 'omniauth-facebook'

gem 'forgery'

gem 'factory_girl_rails'

group :development do
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'pry-rails'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'bootstrap-sass'

  gem 'haml_coffee_assets'
  gem 'execjs'
  
  # # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# We need this outstide of the asset group
# see http://stackoverflow.com/questions/7464900/what-needs-to-be-configured-for-heroku-to-handle-templates-based-on-coffeescript
gem 'coffee-rails' 
gem 'haml'

group :test do
  gem "sqlite3"
  gem 'poltergeist'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', "~> 1.0.1" # see https://github.com/gregbell/active_admin/issues/2388
  gem 'email_spec'
end
