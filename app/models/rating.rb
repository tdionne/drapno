class Rating < ActiveRecord::Base
  belongs_to :rater, :class_name => 'Dreamer', :counter_cache => true
  belongs_to :dream, :counter_cache => true
  
  validates_presence_of :rater_id
  validates_presence_of :dream_id
end
