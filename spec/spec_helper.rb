# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
# require 'spec/rails'
# require 'spec/autorun'
require 'model_mocker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  # config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

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

# # This file is copied to ~/spec when you run 'ruby script/generate rspec'
# # from the project root directory.
# ENV["RAILS_ENV"] ||= 'test'
# require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
# require 'spec/autorun'
# require 'spec/rails'
# require 'model_mocker'
# require "rspec-on-rails-matchers"
# # Requires supporting files with custom matchers and macros, etc,
# # in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
#
# Spec::Runner.configure do |config|
#   config.use_transactional_fixtures = true
#   config.use_instantiated_fixtures  = false
#   config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
#
#   config.mock_with :mocha
#
#   config.before(:each, :type => :controller) do
#     def login_as(username)
#       setup_login_as(controller)
#     end
#   end
#
#   config.before(:each, :type => :view) do
#     def login_as(username)
#       setup_login_as(template)
#     end
#   end
#
#   def setup_login_as(parent)
#     @current_user = User.mock
#     parent.stubs(:signed_in?).returns(true)
#     parent.stubs(:current_user).returns(@current_user)
#     parent.stubs(:authenticate).returns(true)
#   end
# end
