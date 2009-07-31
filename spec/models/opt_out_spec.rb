# == Schema Information
#
# Table name: opt_outs
#
#  id         :integer(4)      not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OptOut do
  describe "validations" do
    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email) }
  end
end
