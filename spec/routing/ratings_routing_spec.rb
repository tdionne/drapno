require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RatingsController do
  # describe "route generation" do
  #   it "maps #index without a dreamer id" do
  #     route_for(:controller => "ratings", :action => "index").should == "/ratings"
  #   end
  #
  #   it "maps #index" do
  #     route_for(:controller => "ratings", :action => "index", :dreamer_id => '1').should == "/dreamers/1/ratings"
  #   end
  #
  #   it "maps #create" do
  #     route_for(:controller => "ratings", :action => "create", :dreamer_id => '1').should == {:path => "/dreamers/1/ratings", :method => :post}
  #   end
  # end

  describe "route recognition" do
    
    it "generates params for the shallow index route" do
      expect(:get => '/ratings').to route_to(:controller => "ratings", :action => "index")
      # params_from(:get, "/ratings").should == {:controller => 'ratings', :action => 'index'}
    end
    
    it "generates params for #index" do
      expect(:get => '/dreamers/1/ratings').to route_to(:controller => "ratings", :action => "index", :dreamer_id => '1')
      # params_from(:get, "/dreamers/1/ratings").should == {:controller => "ratings", :action => "index", :dreamer_id => '1'}
    end

    it "generates params for #create" do
      expect(:post => '/dreamers/1/ratings').to route_to(:controller => "ratings", :action => "create", :dreamer_id => '1')
      # params_from(:post, "/dreamers/1/ratings").should == {:dreamer_id => '1', :controller => "ratings", :action => "create"}
    end
  end
end
