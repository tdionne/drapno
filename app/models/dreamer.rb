class Dreamer < ActiveRecord::Base
  include Clearance::User
  
  has_many :dreams
  has_many :appearances, :foreign_key => :apparition_id
  
  validates_presence_of :name
  
  attr_accessible :name
  
  def is_admin?
    true
  end
end
