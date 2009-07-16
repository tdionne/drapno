require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitation do
  describe "validations" do
    it { should validate_presence_of(:email) }
  end
  
  it "generates a code on create" do
    invitation = Invitation.new
    invitation.expects(:generate_code)
    invitation.send(:callback, :before_create)
  end

  it { should have_named_scope(:redeemable).finding(:conditions => {:redeemed_at => nil}) }
  
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
