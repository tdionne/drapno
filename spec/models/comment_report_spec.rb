require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentReport do
  describe "associations" do
    it { should belong_to(:comment) }
    it { should belong_to(:reporter) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:comment_id) }
    it { should validate_presence_of(:reporter_id) }    
    it { should validate_presence_of(:reason) }
  end
end
