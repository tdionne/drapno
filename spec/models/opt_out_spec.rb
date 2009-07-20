require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OptOut do
  describe "validations" do
    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email) }
  end
end
