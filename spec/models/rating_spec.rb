require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do
  describe "associations" do
    it { should belong_to(:dream) }
    it { should belong_to(:rater) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:rater_id) }
    it { should validate_presence_of(:dream_id) }
  end
end
