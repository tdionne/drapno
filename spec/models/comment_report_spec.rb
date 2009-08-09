# == Schema Information
#
# Table name: comment_reports
#
#  id          :integer(4)      not null, primary key
#  reporter_id :integer(4)
#  comment_id  :integer(4)
#  reason      :text
#  created_at  :datetime
#  updated_at  :datetime
#

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
