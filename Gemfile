source :gemcutter
source "http://gems.github.com"

gem 'rake', '~> 0.8.7'
gem 'rails', '2.3.10'
gem 'mysql'

platforms :ruby_18 do
  gem 'SystemTimer'
end

gem 'paperclip', '~> 2.3.1'
gem 'clearance', '0.8.4'
gem 'will_paginate', '2.3.12'
gem 'delayed_job', '~> 2.0.0'

gem "thinking-sphinx", '~> 1.3.8'
gem 'ts-delayed-delta', '~> 1.1.0', :require => 'thinking_sphinx/deltas/delayed_delta'

gem 'jnunemaker-validatable', :source => 'http://rubygems.org/'
gem "mbleigh-acts-as-taggable-on", '~> 1.0.5', :source => 'http://rubygems.org', :require => "acts-as-taggable-on"
gem "RedCloth", '~> 4.2.9', :require => 'redcloth'
gem "mongo_mapper", '~> 0.8.6'
gem 'bson_ext'

gem 'oauth'
gem 'oauth-plugin'
gem 'twitter', '4.0.0'
gem 'base58'
gem 'faraday', '0.8'
gem 'facebooker'

gem 'capistrano'
gem 'capistrano-ext'

gem 'hoptoad_notifier'
gem 'test-unit', '1.2.3'

group :development do
  gem 'foreman'
end
  
group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  
  gem 'rspec-rails', '~> 1.3.1'
  gem 'factory_girl'
  gem 'shoulda'
  gem 'fakeweb'
  
  gem 'cucumber-rails', '~> 0.3.2'
  gem 'database_cleaner'
  gem 'webrat'
  gem 'mocha'
end
