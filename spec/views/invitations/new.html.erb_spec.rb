require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/invitations/new.html.erb" do
  include InvitationsHelper

  before(:each) do
    assigns[:invitation] = Invitation.mock { |i| i.as_new_record }
  end

  it "renders new invitation form" do
    render

    response.should have_tag("form[action=?][method=post]", invitations_path) do
    end
  end
end
