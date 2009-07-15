require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dream do
  describe "associations" do
    it { should belong_to(:dreamer) }
  end
  
  describe "validations" do
    
  end
end
