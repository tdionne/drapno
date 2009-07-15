require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DreamsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "dreams", :action => "index").should == "/dreams"
    end

    it "maps #new" do
      route_for(:controller => "dreams", :action => "new").should == "/dreams/new"
    end

    it "maps #show" do
      route_for(:controller => "dreams", :action => "show", :id => "1").should == "/dreams/1"
    end

    it "maps #edit" do
      route_for(:controller => "dreams", :action => "edit", :id => "1").should == "/dreams/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "dreams", :action => "create").should == {:path => "/dreams", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "dreams", :action => "update", :id => "1").should == {:path =>"/dreams/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "dreams", :action => "destroy", :id => "1").should == {:path =>"/dreams/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/dreams").should == {:controller => "dreams", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/dreams/new").should == {:controller => "dreams", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/dreams").should == {:controller => "dreams", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/dreams/1").should == {:controller => "dreams", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/dreams/1/edit").should == {:controller => "dreams", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/dreams/1").should == {:controller => "dreams", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/dreams/1").should == {:controller => "dreams", :action => "destroy", :id => "1"}
    end
  end
end
