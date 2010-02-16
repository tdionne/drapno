# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'paperclip', :source => 'http://gemcutter.org', :version => '>=2.3.1'
  config.gem 'clearance', :source => 'http://gemcutter.org', :version => '0.8.4'
  config.gem 'will_paginate', :source => 'http://gemcutter.org', :version => '>=2.3.11'
  config.gem 'collectiveidea-delayed_job', :lib => 'delayed_job', :source => 'http://gems.github.com', :version => '>=1.8.0'

  config.gem "thinking-sphinx", :lib => 'thinking_sphinx', :source => 'http://gemcutter.org', :version => '>= 1.3.8'
  config.gem 'ts-delayed-delta', :lib => 'thinking_sphinx/deltas/delayed_delta', :version => '>= 1.0.0', :source  => 'http://gemcutter.org'

  config.gem "mbleigh-acts-as-taggable-on", :source => "http://gems.github.com", :lib => "acts-as-taggable-on", :version => '1.0.5'
  config.gem "RedCloth", :lib => 'redcloth'
  config.gem "mongomapper", :version => '>0.3.4'
  
  config.gem 'oauth'
  config.gem 'oauth-plugin'
  
  config.frameworks -= [ :active_resource ]

  config.time_zone = 'UTC'
  
  config.after_initialize do  
    MongoMapper.database = "mdb_drapno_#{Rails.env}"
  end
end

DO_NOT_REPLY = "DRAPNO <donotreply@drapno.com>"
