class Dream < ActiveRecord::Base
  belongs_to :dreamer
  has_many :appearances
  accepts_nested_attributes_for :appearances
  
  validates_presence_of :title
  validates_presence_of :story
  validates_presence_of :dreamer_id
  
  acts_as_taggable_on :tags
  
  define_index do
    indexes title
    indexes story
    indexes dreamer(:name), :as => :dreamer
    indexes tags(:name), :as => :tag_names
    
    set_property :delta => :delayed
  end
end
