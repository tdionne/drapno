class CommentReport < ActiveRecord::Base
  belongs_to :comment
  belongs_to :reporter, :class_name => 'Dreamer'
  
  validates_presence_of :comment_id, :reporter_id, :reason
end
