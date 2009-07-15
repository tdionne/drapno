class Dreamer < ActiveRecord::Base
  include Clearance::User
  
  has_many :dreams
  
  validates_presence_of :name
  
  attr_accessible :name
end
