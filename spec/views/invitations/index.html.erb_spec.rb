require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/invitations/index.html.erb" do
  include InvitationsHelper

  before(:each) do
    assigns[:invitations] = [
      Invitation.mock(:id => 1),
      Invitation.mock(:id => 2)
    ]
  end

  it "renders a list of invitations" do
    render
  end
end
