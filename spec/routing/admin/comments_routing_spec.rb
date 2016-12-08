require 'rails_helper'

RSpec.describe 'Comments Controller Routing' do
  describe "route generation", :type => :routing do
    it "maps #index" do
      expect(route_to(:controller => "admin/comments", :action => "index").matches?("/admin/comments"))
    end

    it "maps #edit" do
      route_to(:controller => "admin/comments", :action => "edit", :id => "1").should == "/admin/comments/1/edit"
    end

    it "maps #update" do
      route_to(:controller => "admin/comments", :action => "update", :id => "1").should == {:path =>"/admin/comments/1", :method => :put}
    end

    it "maps #destroy" do
      route_to(:controller => "admin/comments", :action => "destroy", :id => "1").should == {:path =>"/admin/comments/1", :method => :delete}
    end
  end

  describe "route recognition", :type => :routing do
    it "generates params for #index" do
      expect(:get => '/admin/comments').to route_to(:controller => "admin/comments", :action => "index")
      # params_from(:get, "/admin/comments").should == {:controller => "admin/comments", :action => "index"}
    end

    it "generates params for #edit" do
      params_from(:get, "/admin/comments/1/edit").should == {:controller => "admin/comments", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/admin/comments/1").should == {:controller => "admin/comments", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin/comments/1").should == {:controller => "admin/comments", :action => "destroy", :id => "1"}
    end
  end
end
