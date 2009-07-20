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
  
  describe "notifications" do
    before(:each) do
      @appearance = Appearance.new(:email => 'sample@example.com')
      UserMailer.stubs(:deliver_appearance)
    end
    
    it "invokes the relevant callback" do
      @appearance.expects(:send_notification)
      @appearance.send(:callback, :after_create)
    end
    
    it "sends an email to this person if they should be notified" do
      @appearance.should_be_notified = '1'
      UserMailer.expects(:send_later).with(:deliver_appearance, @appearance)
      @appearance.send(:callback, :after_create)
    end
  end
end
