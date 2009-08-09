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

class Follow < ActiveRecord::Base
  belongs_to :follower, :class_name => 'Dreamer'
  belongs_to :dreamer
  
  validates_uniqueness_of :follower_id, :scope => :dreamer_id
  validates_presence_of :follower_id, :dreamer_id
end
