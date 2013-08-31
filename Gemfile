source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'

# Servers
gem 'puma'
gem 'unicorn'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'devise'

gem 'authlogic'
gem 'cancan'
# Multi-environment configuration
# gem 'simpleconfig'

# API
# gem 'rabl'
gem 'paypal-sdk-merchant'
gem 'sidekiq'

# ORM
gem 'pg'

# Performance and Exception management
# gem 'airbrake'
# gem 'newrelic_rpm'

# Security
# gem 'secure_headers'

# Miscellanea
# gem 'google-analytics-rails'
# gem 'haml'
# gem 'http_accept_language'
gem 'jquery-rails'
gem 'nokogiri'
# gem 'resque', require: 'resque/server' # Resque web interface

# Assets
gem 'coffee-rails', '~> 4.0.0'
# gem 'haml_assets'

# gem 'handlebars_assets'
gem 'i18n-js'
gem 'jquery-turbolinks'
gem 'less-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'therubyracer'
gem 'turbolinks'
gem 'twitter-bootstrap-rails', :git => 'https://github.com/diowa/twitter-bootstrap-rails', branch: 'fontawesome-3.2.1'
gem "bootstrap-modal-rails"
gem 'uglifier', '>= 1.3.0'
gem 'coderay'

#gems for markdown
gem 'redcarpet'
gem 'markdown-rails'

#gem liquid
gem 'liquid'

#e-mail
gem 'actionmailer'
gem 'mail'

#file upload gem
gem 'carrierwave', '~> 0.9'
gem 'mini_magick'
gem 'bootstrap-sass', '~> 2.3.2'

#Bloggy - jekyll engine integration
gem 'bloggy'
#gem required for static pages
gem 'pygments.rb', '~> 0.3.7'
  gem 'RedCloth', '~> 4.2.9'
  gem 'haml', '~> 3.1.6'
  gem 'compass', '~> 0.12.1'
  gem 'rubypants', '~> 0.2.0'
  gem 'rb-fsevent', '~> 0.9'
  gem 'stringex', '~> 1.4.0'
  gem 'git_remote_branch'
  gem 'gsl'
  gem 'term-ansicolor', '~> 1.0.7'
  gem 'sinatra', '~> 1.3.2'
  
#localization gem
gem 'countries'
gem 'country_select', require: false
  
group :development, :test do
  #gem 'debugger','~>1.6.0'
  gem 'delorean'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano'
  gem 'capistrano-unicorn', :git => 'https://github.com/sosedoff/capistrano-unicorn.git', :branch => 'master', :require => false
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webmock', require: false
end

group :staging, :production do
  gem 'rails_12factor'
end
