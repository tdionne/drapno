require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitationsController do
  # describe "route generation" do
  #   it "maps #index" do
  #     route_for(:controller => "invitations", :action => "index").should == "/invitations"
  #   end
  #
  #   it "maps #new" do
  #     route_for(:controller => "invitations", :action => "new").should == "/invitations/new"
  #   end
  #
  #   it "maps #create" do
  #     route_for(:controller => "invitations", :action => "create").should == {:path => "/invitations", :method => :post}
  #   end
  # end

  describe "route recognition" do
    it "generates params for #index" do
      expect(:get => '/invitations').to route_to(:controller => "invitations", :action => "index")
      # params_from(:get, "/invitations").should == {:controller => "invitations", :action => "index"}
    end

    it "generates params for #new" do
      expect(:get => '/invitations/new').to route_to(:controller => "invitations", :action => "new")
      # params_from(:get, "/invitations/new").should == {:controller => "invitations", :action => "new"}
    end

    it "generates params for #create" do
      expect(:post => '/invitations').to route_to(:controller => "invitations", :action => "create")
      # params_from(:post, "/invitations").should == {:controller => "invitations", :action => "create"}
    end
  end
end
