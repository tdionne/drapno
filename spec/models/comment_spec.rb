# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  dream_id   :integer(4)
#  dreamer_id :integer(4)
#  status     :string(12)      default("visible"), not null
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

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
