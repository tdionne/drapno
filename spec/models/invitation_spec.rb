# == Schema Information
#
# Table name: invitations
#
#  id              :integer(4)      not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  invitation_code :string(40)
#  invited_at      :datetime
#  redeemed_at     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitation do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should allow_value('james@ketlai.co.uk').for(:email) }
    it { should allow_value('james.stewart@test.site.ketlai.co.uk').for(:email) }
    it { should_not allow_value('james').for(:email) }
  end
  
  it "generates a code on create" do
    invitation = Invitation.new
    invitation.expects(:generate_code)
    invitation.send(:callback, :before_create)
  end
  
  describe "marking as redeemed" do
    it "has a method to allow redemption" do
      Invitation.new.respond_to?(:redeem!).should be_true
    end
    
    it "sets the redeemed_at time and saves" do
      i = Invitation.mock
      i.expects(:redeemed_at=)
      i.expects(:save!)
      i.redeem!
    end
  end

  
end
