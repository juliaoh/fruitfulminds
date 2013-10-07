source 'http://rubygems.org'

gem 'rails', '3.1.10'

gem 'googlecharts', :require => 'gchart'
gem 'haml'
gem 'jquery-rails'
gem 'prawn'

# Assets use the following Gems; production does not require them.
group :assets do
  gem 'therubyracer'
  gem 'sass-rails', " ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

# For form field errors
gem "dynamic_form"
gem "strip_attributes"
gem 'haml', :require => "open-uri"

# For email validation
gem 'validates_email_format_of' #, :git => 'git://github.com/alexdunae/validates_email_format_of.git'
gem 'bcrypt-ruby'

# For Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'railroady'
  gem 'haml-rails'
  gem 'simplecov'
end
group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'railroady'
  gem 'haml-rails'
  gem 'autotest-rails'
  gem 'pdf-reader'
end
group :production do
  gem 'pg'
end
