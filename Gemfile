source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.1'

# Full-stack web application framework. (https://rubyonrails.org)
gem 'rails', '~> 7.0.3'

# Pg is the Ruby interface to the PostgreSQL RDBMS (https://github.com/ged/ruby-pg)
gem 'pg', '>= 0.18', '< 2.0'

# Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications (https://puma.io)
gem 'puma', '~> 5.0'

# Use Vite in Rails and bring joy to your JavaScript experience (https://github.com/ElMassimo/vite_ruby)
gem 'vite_rails'

# Create JSON structures via a Builder-style DSL (https://github.com/rails/jbuilder)
gem 'jbuilder'

# High-level wrapper for processing images for the web with ImageMagick or libvips. (https://github.com/janko/image_processing)
gem 'image_processing', '~> 1.2'

# Boot large ruby/rails apps faster (https://github.com/Shopify/bootsnap)
gem 'bootsnap', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # Debugging functionality for Ruby (https://github.com/ruby/debug)
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]

  # Automatic Ruby code style checking tool. (https://github.com/rubocop/rubocop)
  gem 'rubocop', require: false

  # Automatic performance checking tool for Ruby code. (https://github.com/rubocop/rubocop-performance)
  gem 'rubocop-performance', require: false

  # Automatic Rails code style checking tool. (https://github.com/rubocop/rubocop-rails)
  gem 'rubocop-rails', require: false

  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer (https://github.com/thoughtbot/factory_bot_rails)
  gem 'factory_bot_rails'
end

group :development do
  # A debugging tool for your Ruby on Rails applications. (https://github.com/rails/web-console)
  gem 'web-console'

  # Profiles loading speed for rack applications. (https://miniprofiler.com)
  gem 'rack-mini-profiler'

  # Rails application preloader (https://github.com/rails/spring)
  gem 'spring'

  # Brings Rails named routes to javascript (http://github.com/railsware/js-routes)
  gem 'js-routes', require: false
end

group :test do
  # Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb (https://github.com/teamcapybara/capybara)
  gem 'capybara'

  # Selenium is a browser automation tool for automated testing of webapps and more (https://selenium.dev)
  gem 'selenium-webdriver'

  # Easy download and use of browser drivers. (https://github.com/titusfortner/webdrivers)
  gem 'webdrivers'
end

# Timezone Data for TZInfo (https://tzinfo.github.io)
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Inertia adapter for Rails (https://github.com/inertiajs/inertia-rails)
gem 'inertia_rails', '>= 1.2.2'

# Easily generate fake data (https://github.com/faker-ruby/faker)
gem 'faker', require: false

# The kick-ass pagination ruby gem (https://github.com/ddnexus/pagy)
gem 'pagy'

# Flexible authentication solution for Rails with Warden (https://github.com/heartcombo/devise)
gem 'devise'

# A fast JSON parser and serializer. (http://www.ohler.com/oj)
gem 'oj'

# Simple authorization solution for Rails. (https://github.com/CanCanCommunity/cancancan)
gem 'cancancan'
