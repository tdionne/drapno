# == Schema Information
#
# Table name: dreams
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  story      :text
#  story_html :text
#  dreamer_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  delta      :boolean(1)      default(TRUE), not null
#  location   :string(255)
#  dreamt_on  :date
#

class Dream < ActiveRecord::Base
  belongs_to :dreamer
  has_many :appearances
  accepts_nested_attributes_for :appearances, :reject_if => proc { |attributes| attributes['name'].blank? || attributes['email'].blank? }
  
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
