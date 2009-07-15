require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitation do
  describe "validations" do
    it { should validate_presence_of(:email) }
  end
  
  it "generates a code on create" do
    pending
  end
  
  it "has a named scope for redeemable invitations" do
    pending
  end
  
  it "has a method to allow redemption" do
    pending
  end
  
end
