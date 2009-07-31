# == Schema Information
#
# Table name: opt_outs
#
#  id         :integer(4)      not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class OptOut < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  
  attr_accessor :token
end
