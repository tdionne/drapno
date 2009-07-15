class Dream < ActiveRecord::Base
  belongs_to :dreamer
  
  validates_presence_of :title
  validates_presence_of :story
end
