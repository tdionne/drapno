# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'
require 'model_mocker'
require "rspec-on-rails-matchers"
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  config.mock_with :mocha
  
  config.before(:each, :type => :controller) do
    def login_as(username)
      setup_login_as(controller)
    end
  end
  
  config.before(:each, :type => :view) do
    def login_as(username)
      setup_login_as(template)
    end
  end
  
  def setup_login_as(parent)
    @current_user = User.mock
    parent.stubs(:signed_in?).returns(true)
    parent.stubs(:current_user).returns(@current_user)
    parent.stubs(:authenticate).returns(true)
  end
end
