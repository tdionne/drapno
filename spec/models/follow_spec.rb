require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Follow do
  describe "associations" do
    it { should belong_to(:follower) }
    it { should belong_to(:dreamer) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:follower_id) }
    it { should validate_presence_of(:dreamer_id) }
  end
end
