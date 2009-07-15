require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitationsController do

  before(:each) do
    @mock_invitation ||= Invitation.mock
    login_as :quentin
    @current_user.stubs(:is_admin?).returns(true)
  end

  describe "GET index" do
    it "assigns all invitations as @invitations" do
      Invitation.stubs(:find).with(:all).returns([@mock_invitation])
      get :index
      assigns[:invitations].should == [@mock_invitation]
    end
  end

  describe "GET new" do
    it "assigns a new invitation as @invitation" do
      Invitation.stubs(:new).returns(@mock_invitation)
      get :new
      assigns[:invitation].should equal(@mock_invitation)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      before(:each) do
        @mock_invitation.stubs(:save).returns(true)
        UserMailer.stubs(:deliver_invitation)
      end
      
      it "assigns a newly created invitation as @invitation" do
        Invitation.stubs(:new).with({'these' => 'params'}).returns(@mock_invitation)
        post :create, :invitation => {:these => 'params'}
        assigns[:invitation].should equal(@mock_invitation)
      end

      it "redirects to the created invitation" do
        Invitation.stubs(:new).returns(@mock_invitation)
        post :create, :invitation => {}
        response.should redirect_to(invitations_url)
      end
      
      it "sends the invitation by email" do
        UserMailer.expects(:deliver_invitation).with(@mock_invitation)
        post :create, :invitation => {}
      end
    end

    describe "with invalid params" do
      before(:each) do
        @mock_invitation.stubs(:save).returns(false)
      end
      
      it "assigns a newly created but unsaved invitation as @invitation" do
        Invitation.stubs(:new).with({'these' => 'params'}).returns(@mock_invitation)
        post :create, :invitation => {:these => 'params'}
        assigns[:invitation].should equal(@mock_invitation)
      end

      it "re-renders the 'new' template" do
        Invitation.stubs(:new).returns(@mock_invitation)
        post :create, :invitation => {}
        response.should render_template('new')
      end
    end

  end


end
