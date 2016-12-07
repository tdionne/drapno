# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
# require File.join(File.dirname(__FILE__), 'boot')
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Drapno::Application.initialize!

# Rails::Initializer.run do |config|
#   config.frameworks -= [ :active_resource ]
#   config.active_record.observers = :tweeting_observer
#
#   config.time_zone = 'UTC'
#
#   config.after_initialize do
#     MongoMapper.database = "mdb_drapno_#{Rails.env}"
#   end
# end

DO_NOT_REPLY = "DRAPNO <donotreply@drapno.com>"
