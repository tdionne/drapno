# == Schema Information
#
# Table name: ratings
#
#  id         :integer(4)      not null, primary key
#  score      :integer(4)
#  rater_id   :integer(4)
#  dream_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

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
