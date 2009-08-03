require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  describe "route generation" do
    it "maps #index without a dream id" do
      route_for(:controller => "comments", :action => "index").should == "/comments"
    end

    it "maps #create" do
      route_for(:controller => "comments", :action => "create", :dream_id => '1').should == {:path => "/dreams/1/comments", :method => :post}
    end
  end

  describe "route recognition" do
    
    it "generates params for the shallow index route" do
      params_from(:get, "/comments").should == {:controller => 'comments', :action => 'index'}
    end
    
    it "generates params for #index" do
      params_from(:get, "/comments").should == {:controller => "comments", :action => "index"}
    end

    it "generates params for #create" do
      params_from(:post, "/dreams/1/comments").should == {:dream_id => '1', :controller => "comments", :action => "create"}
    end
  end
end
