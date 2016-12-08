require 'rails_helper'

describe DreamsController, :type => :controller do
  # describe "route generation" do
  #   it "maps #index" do
  #     route_for(:controller => "dreams", :action => "index").should == "/dreams"
  #   end
  #
  #   it "maps #new" do
  #     route_for(:controller => "dreams", :action => "new").should == "/dreams/new"
  #   end
  #
  #   it "maps #show" do
  #     route_for(:controller => "dreams", :action => "show", :id => "1").should == "/dreams/1"
  #   end
  #
  #   it "maps #edit" do
  #     route_for(:controller => "dreams", :action => "edit", :id => "1").should == "/dreams/1/edit"
  #   end
  #
  #   it "maps #create" do
  #     route_for(:controller => "dreams", :action => "create").should == {:path => "/dreams", :method => :post}
  #   end
  #
  #   it "maps #update" do
  #     route_for(:controller => "dreams", :action => "update", :id => "1").should == {:path =>"/dreams/1", :method => :put}
  #   end
  #
  #   it "maps #destroy" do
  #     route_for(:controller => "dreams", :action => "destroy", :id => "1").should == {:path =>"/dreams/1", :method => :delete}
  #   end
  # end

  describe "route recognition" do
    it "generates params for #index" do
      expect(:get => '/dreams').to route_to(:controller => "dreams", :action => "index")
      # params_from(:get, "/dreams").should == {:controller => "dreams", :action => "index"}
    end

    it "generates params for #new" do
      expect(:get => '/dreams/new').to route_to(:controller => "dreams", :action => "new")
      # params_from(:get, "/dreams/new").should == {:controller => "dreams", :action => "new"}
    end

    it "generates params for #create" do
      expect(:post => '/dreams').to route_to(:controller => "dreams", :action => "create")
      # params_from(:post, "/dreams").should == {:controller => "dreams", :action => "create"}
    end

    it "generates params for #show" do
      expect(:get => '/dreams/1').to route_to(:controller => "dreams", :action => "show", :id => '1')
      # params_from(:get, "/dreams/1").should == {:controller => "dreams", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      expect(:get => '/dreams/1/edit').to route_to(:controller => "dreams", :action => "edit", :id => "1")
      # params_from(:get, "/dreams/1/edit").should == {:controller => "dreams", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      expect(:put => '/dreams/1/').to route_to(:controller => "dreams", :action => "update", :id => "1")
      # params_from(:put, "/dreams/1").should == {:controller => "dreams", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      expect(:delete => '/dreams/1').to route_to(:controller => "dreams", :action => "destroy", :id => "1")
      # params_from(:delete, "/dreams/1").should == {:controller => "dreams", :action => "destroy", :id => "1"}
    end
  end
end
