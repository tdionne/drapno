require 'rails_helper'

describe FollowsController do
  # describe "route generation" do
  #   it "maps #create" do
  #     route_for(:controller => "follows", :action => "create", :dreamer_id => '1').should == {:path => "/dreamers/1/follows", :method => :post}
  #   end
  #
  #   it "maps #destroy" do
  #     route_for(:controller => "follows", :action => "destroy", :dreamer_id => '1', :id => "1").should == {:path =>"/dreamers/1/follows/1", :method => :delete}
  #   end
  #
  #   it "maps #index" do
  #     route_for(:controller => "follows", :action => "index").should == {:path =>"/follows", :method => :get}
  #   end
  # end

  describe "route recognition" do

    it "generats params for #index" do
      expect(:get => '/follows').to route_to(:controller => "follows", :action => "index")
      # params_from(:get, "/follows").should == {:controller => "follows", :action => "index"}
    end
    
    it "generates params for #create" do
      expect(:post => '/dreamers/1/follows').to route_to(:controller => "follows", :action => "create", :dreamer_id => '1')
      # params_from(:post, "/dreamers/1/follows").should == {:controller => "follows", :action => "create", :dreamer_id => '1'}
    end

    it "generates params for #destroy" do
      expect(:delete => '/dreamers/1/follows/1').to route_to(:controller => "follows", :action => "destroy", :dreamer_id => '1', :id => '1')
      # params_from(:delete, "/dreamers/1/follows/1").should == {:controller => "follows", :action => "destroy", :dreamer_id => '1', :id => "1"}
    end
  end
end
