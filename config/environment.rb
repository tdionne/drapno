# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com', :version => '2.3.1'
  config.gem 'thoughtbot-clearance', :lib => 'clearance', :source => 'http://gems.github.com', :version => '0.8.2'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com', :version => '2.3.11'
  config.gem 'collectiveidea-delayed_job', :lib => 'delayed_job', :source => 'http://gems.github.com', :version => '>=1.8.0'
  config.gem 'freelancing-god-thinking-sphinx', :lib => 'thinking_sphinx', :version => '>=1.1.23'
  config.gem "mbleigh-acts-as-taggable-on", :source => "http://gems.github.com", :lib => "acts-as-taggable-on", :version => '1.0.5'
  config.gem "RedCloth", :lib => 'redcloth'
  config.gem "mongomapper", :version => '>0.3.4'
  
  config.frameworks -= [ :active_resource ]

  config.time_zone = 'UTC'
end

DO_NOT_REPLY = "DRAPNO <donotreply@drapno.com>"
MongoMapper.database = "mdb_drapno_#{Rails.env}"
