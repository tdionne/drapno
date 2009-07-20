# == Schema Information
#
# Table name: appearances
#
#  id            :integer(4)      not null, primary key
#  role          :string(32)
#  dream_id      :integer(4)
#  apparition_id :integer(4)
#  name          :string(64)
#  email         :string(64)
#  created_at    :datetime
#  updated_at    :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Appearance do
  describe "associations" do
    it { should belong_to(:dream) }
    it { should belong_to(:apparition) }    
  end
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end
  
  describe "checking for a matching dreamer before create" do
    before(:each) do
      @appearance = Appearance.new(:email => 'sample@example.com')
    end
    
    it "invokes the relevant callback" do
      @appearance.expects(:identify_apparition)
      @appearance.send(:callback, :before_create)
    end
    
    it "looks for the dreamer with a matching email address" do
      Dreamer.expects(:find_by_email).with(@appearance.email)
      @appearance.send(:identify_apparition)
    end
  end
  
  it "generates an identifier token before save" do
    @appearance = Appearance.new(:email => 'sample@example.com')
    @appearance.stubs(:identify_apparition)
    @appearance.expects(:generate_token)
    @appearance.send(:callback, :before_create)
  end
  
  describe "notification" do
    before(:each) do
      @appearance = Appearance.new(:email => 'sample@example.com', :should_be_notified => '1')
      UserMailer.stubs(:send_later)
      OptOut.stubs(:exists?).returns(false)
    end
    
    it "invokes the relevant callback" do
      @appearance.expects(:send_notification)
      @appearance.send(:callback, :after_create)
    end
    
    it "checks whether the email address has opted out" do
      OptOut.expects(:exists?).with(:email => 'sample@example.com').returns(false)
      @appearance.send(:send_notification)
    end
    
    it "checks whether the user has requested that a notification be sent" do
      @appearance.expects(:should_be_notified?).returns(true)
      @appearance.send(:send_notification)      
    end
    
    it "sends an email to this person if they should be notified" do
      UserMailer.expects(:send_later).with(:deliver_appearance, @appearance)
      @appearance.send(:callback, :after_create)
    end
  end
end
