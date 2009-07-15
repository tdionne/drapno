RAILS_ENV = 'test'
begin
  require 'rubygems'
  require 'activesupport'
  require 'spec'
  gem 'rspec-rails'
  require 'spec/rails'
  
rescue LoadError
  puts $!.inspect
  puts "Please install rspec, rspec-rails and mocha to run the tests."
  exit 1
end

$:.push(File.dirname(__FILE__) + '/../lib')

Spec::Runner.configure do |config|
  config.mock_with :mocha
end