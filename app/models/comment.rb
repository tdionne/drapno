class Comment < ActiveRecord::Base
  belongs_to :dream
  belongs_to :dreamer
  has_many :reports, :class_name => 'CommentReport'
  
  validates_presence_of :dream_id, :dreamer_id, :body
end
