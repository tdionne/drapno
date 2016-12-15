# == Schema Information
#
# Table name: dreams
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  story          :text
#  story_html     :text
#  dreamer_id     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  delta          :boolean(1)      default(TRUE), not null
#  location       :string(255)
#  dreamt_on      :date
#  ratings_count  :integer(4)      default(0), not null
#  average_rating :decimal(5, 3)   default(0.0), not null
#  comments_count :integer(4)      default(0), not null
#

class Dream < ActiveRecord::Base
  belongs_to :dreamer
  has_many :appearances
  has_many :apparitions, :through => :appearances
  has_many :ratings
  has_many :raters, :through => :ratings
  has_many :comments
  has_many :available_comments, :class_name => 'Comment', :conditions => ['comments.status IN (?)', %W{visible reported hidden}]

  accepts_nested_attributes_for :appearances, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['name'].blank? || attributes['email'].blank? }

  attr_accessible :title
  attr_accessible :story
  attr_accessible :dreamt_on
  attr_accessible :tag_list
  
  validates_presence_of :title
  validates_presence_of :story
  validates_presence_of :dreamer_id
  validates_presence_of :dreamt_on
  
  # named_scope :listings, :order => 'created_at DESC', :select => 'dreams.id, dreams.title, dreams.story, dreams.dreamer_id, dreams.created_at, dreams.dreamt_on', :include => :dreamer
  # named_scope :rated, :order => ['average_rating DESC'], :conditions => 'dreams.ratings_count > 0'
  acts_as_taggable
  
  attr_accessor :tweet_dream
  
  # xss_terminate
  
  def to_s
    self.title
  end
  
  def b58
    Base58.encode(self.id)
  end
  
  # define_index do
  #   indexes title
  #   indexes story
  #   indexes dreamer(:name), :as => :dreamer
  #   indexes tags(:name), :as => :tag_names
  #
  #   set_property :delta => :delayed
  # end
  
  def created_on
    created_at.to_date
  end
  
  def dreamer_followers
    dreamer.followers
  end
  
  # include ActivityMonitor
  # monitor_activity :object_details => proc { |dream| [dream.id, dream.title] },
  #   :verb => 'shared',
  #   :parties => {
  #     :apparitions => 'featuring you',
  #     :dreamer_followers => ''
  #   }
  
end
