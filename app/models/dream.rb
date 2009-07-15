class Dream < ActiveRecord::Base
  belongs_to :dreamer
  
  validates_presence_of :title
  validates_presence_of :story
  validates_presence_of :dreamer_id
  
  define_index do
    indexes title
    indexes story
    indexes dreamer(:name), :as => :dreamer
  end
end
