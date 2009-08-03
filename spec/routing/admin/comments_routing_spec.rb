require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CommentsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/comments", :action => "index").should == "/admin/comments"
    end

    it "maps #show" do
      route_for(:controller => "admin/comments", :action => "show", :id => "1").should == "/admin/comments/1"
    end

    it "maps #edit" do
      route_for(:controller => "admin/comments", :action => "edit", :id => "1").should == "/admin/comments/1/edit"
    end

    it "maps #update" do
      route_for(:controller => "admin/comments", :action => "update", :id => "1").should == {:path =>"/admin/comments/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/comments", :action => "destroy", :id => "1").should == {:path =>"/admin/comments/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/comments").should == {:controller => "admin/comments", :action => "index"}
    end

    it "generates params for #show" do
      params_from(:get, "/admin/comments/1").should == {:controller => "admin/comments", :action => "show", :id => "1"}
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
