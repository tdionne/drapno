class CommentReport < ActiveRecord::Base
  belongs_to :comment
  belongs_to :reporter, :class_name => 'Dreamer'
  
  validates_presence_of :comment_id, :reporter_id, :reason
  
  after_create :update_comment_status
  
  def update_comment_status
    comment.update_attribute(:status, 'reported')
  end
end
