require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dreamer do
  describe "associations" do
    it { should have_many(:dreams) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:email) }
  end
end
