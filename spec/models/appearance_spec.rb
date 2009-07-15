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
  
  it "checks for a matching dreamer before create" do
    pending
  end
end
