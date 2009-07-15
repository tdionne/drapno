require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'spec/rails/matchers/rescuable'
require 'active_support'

class RescuableMatchers
  include Spec::Rails::Matchers
  include Spec::Matchers
end

describe "ActiveSupport rescuable matchers" do
  before(:each) do
    @klass = Class.new
    @klass.class_eval do 
      include ActiveSupport::Rescuable
      rescue_from ArgumentError, :with => :arg_handler
      
      def arg_handler(*args); end
    end
    
    @matchers = RescuableMatchers.new
    @instance = @klass.new
  end
  
  it "should report that the instance rescues ArgumentError with #arg_handler" do
    @instance.should @matchers.rescue_exception(ArgumentError.new, :with => :arg_handler)
  end
  
  it "should report that the instance does NOT rescue Exception with #arg_handler" do
    @instance.should_not @matchers.rescue_exception(Exception.new, :with => :arg_handler)
  end
end