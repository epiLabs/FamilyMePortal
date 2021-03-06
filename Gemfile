source 'https://rubygems.org'

gem 'rails', "~> 3.2.14"
gem 'rails-i18n', '~> 3.0.0'

gem 'pg'
gem 'mysql2'
gem 'thin'

# Authentication
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'

gem "simple_form"

gem 'json_builder'

gem 'geocoder'

gem 'gravtastic'

gem 'omniauth'
gem 'omniauth-facebook'

gem 'forgery'

gem 'icalendar'

gem 'factory_girl_rails'
gem 'entypo-rails'

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
  # gem 'bootstrap-sass'

  gem 'execjs'

  # # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

end

gem 'uglifier'
gem 'sass-rails'
gem 'anjlab-bootstrap-rails', '>= 3.0.0.0', :require => 'bootstrap-rails' # Only version with bootstrap3 for the moment

# Needed in gemfile for usj adaptator
gem 'jquery-rails'
# We need this outstide of the asset group
# see http://stackoverflow.com/questions/7464900/what-needs-to-be-configured-for-heroku-to-handle-templates-based-on-coffeescript
gem 'coffee-rails'
gem 'haml'

gem 'http_accept_language'

group :test do
  gem "sqlite3"
  gem 'poltergeist'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', "~> 1.0.1" # see https://github.com/gregbell/active_admin/issues/2388
  gem 'email_spec'
end
