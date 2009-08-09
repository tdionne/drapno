# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  dream_id   :integer(4)
#  dreamer_id :integer(4)
#  status     :string(12)      default("visible"), not null
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :dream, :counter_cache => true
  belongs_to :dreamer, :counter_cache => true
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
