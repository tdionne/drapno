source "http://rubygems.org"

ruby '2.2.5'

gem 'rake'
gem 'rails', '3.2.22'
gem 'activerecord-mysql-adapter'
gem 'mysql2', '0.3.18'
gem 'postgresql'

platforms :ruby_18 do
  gem 'SystemTimer'
end

gem 'paperclip'
gem 'clearance'
gem 'will_paginate'
gem 'delayed_job'

gem "thinking-sphinx"
gem 'ts-delayed-delta', :require => 'thinking_sphinx/deltas/delayed_delta'

gem 'jnunemaker-validatable', :source => 'http://rubygems.org/'
gem "mbleigh-acts-as-taggable-on", '~> 1.0.5', :source => 'http://rubygems.org', :require => "acts-as-taggable-on"
gem "RedCloth", '~> 4.2.9', :require => 'redcloth'
gem "mongo_mapper"
gem 'bson_ext'

gem 'oauth'
gem 'oauth-plugin'
gem 'twitter', '4.0.0'
gem 'base58'
gem 'faraday', '0.8'
gem 'facebooker', :git => 'https://github.com/tdionne/facebooker.git'
gem 'json', '2.0.2'
gem 'dynamic_form'

gem 'capistrano'
gem 'capistrano-ext'
gem 'iconv'
gem 'i18n'
gem 'activesupport', '3.2.22'
gem 'minitest'
gem 'railties'
gem 'loofah-activerecord'
gem 'hoptoad_notifier'
gem 'test-unit', '2.5.5'
group :production do
  # gem 'postgresql'
end
group :development do
  gem 'foreman'
  # gem 'postgresql'
end
  
group :test do
  gem 'sqlite3', :require => 'sqlite3'
  
  gem 'rspec-rails'
  gem 'rspec'
  gem 'factory_girl'
  gem 'shoulda'
  gem 'fakeweb'
  
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'webrat'
  gem 'mocha'
  gem 'model_mocker'
end
