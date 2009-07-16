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
end
