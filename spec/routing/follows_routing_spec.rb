require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FollowsController do
  describe "route generation" do
    it "maps #create" do
      route_for(:controller => "follows", :action => "create", :dreamer_id => '1').should == {:path => "/dreamers/1/follows", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "follows", :action => "destroy", :dreamer_id => '1', :id => "1").should == {:path =>"/dreamers/1/follows/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "generates params for #create" do
      params_from(:post, "/dreamers/1/follows").should == {:controller => "follows", :action => "create", :dreamer_id => '1'}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/dreamers/1/follows/1").should == {:controller => "follows", :action => "destroy", :dreamer_id => '1', :id => "1"}
    end
  end
end
