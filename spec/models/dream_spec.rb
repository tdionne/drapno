require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dream do
  describe "associations" do
    it { should belong_to(:dreamer) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:story) }
    it { should validate_presence_of(:dreamer_id) }
  end
end
