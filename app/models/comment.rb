class Comment < ActiveRecord::Base
  belongs_to :dream
  belongs_to :dreamer
  has_many :reports, :class_name => 'CommentReport'
  
  validates_presence_of :dream_id, :dreamer_id, :body
  
  STATUSES = %W(pending visible reported hidden spam)
  named_scope :available, :conditions => {:status => %W{visible reported hidden}}
  
  STATUSES.each do |status|
    define_method("#{status}?") do
      self.status == status
    end
    
    named_scope status.to_sym, :conditions => {:status => status}
  end
  
end
