require 'rails_helper'
describe CommentsController do
  # describe "route generation" do
  #   it "maps #index without a dream id" do
  #     route_for(:controller => "comments", :action => "index").should == "/comments"
  #   end
  #
  #   it "maps #create" do
  #     route_for(:controller => "comments", :action => "create", :dream_id => '1').should == {:path => "/dreams/1/comments", :method => :post}
  #   end
  # end

  describe "route recognition" do
    
    it "generates params for the shallow index route" do
      expect(:get => '/comments').to route_to(:controller => 'comments', :action => 'index')
      # params_from(:get, "/comments").should == {:controller => 'comments', :action => 'index'}
    end
    
    it "generates params for #index" do
      expect(:get => '/comments').to route_to(:controller => 'comments', :action => 'index')
      # params_from(:get, "/comments").should == {:controller => "comments", :action => "index"}
    end

    it "generates params for #create" do
      expect(:post => '/dreams/1/comments').to route_to(:controller => 'comments', :dream_id => '1', :action => 'create')
      # params_from(:post, "/dreams/1/comments").should == {:dream_id => '1', :controller => "comments", :action => "create"}
    end
  end
end
