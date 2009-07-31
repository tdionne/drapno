require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  describe "associations" do
    it { should belong_to(:dream) }
    it { should belong_to(:dreamer) }    
    it { should have_many(:reports) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:dream_id) }
    it { should validate_presence_of(:dreamer_id) }
    it { should validate_presence_of(:body) }
  end
end
