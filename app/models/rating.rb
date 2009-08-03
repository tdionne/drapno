# == Schema Information
#
# Table name: ratings
#
#  id         :integer(4)      not null, primary key
#  score      :integer(4)
#  rater_id   :integer(4)
#  dream_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Rating < ActiveRecord::Base
  belongs_to :rater, :class_name => 'Dreamer', :counter_cache => true
  belongs_to :dream, :counter_cache => true
  
  validates_presence_of :rater_id
  validates_presence_of :dream_id
  
  after_save :update_dream
  
  def update_dream
    dream.update_attributes(
      :average_rating => dream.ratings.average(:score),
      :ratings_count => dream.ratings.count
    )
  end
end
