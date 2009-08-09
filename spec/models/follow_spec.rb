# == Schema Information
#
# Table name: follows
#
#  id          :integer(4)      not null, primary key
#  dreamer_id  :integer(4)
#  follower_id :integer(4)
#  reciprocal  :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

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
