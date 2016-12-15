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

  attr_accessible :body
  attr_accessible :dreamer_id

  STATUSES = %W(pending visible reported hidden spam)
  # named_scope :available, :conditions => {:status => %W{visible reported hidden}}
  
  after_create :send_notification
  
  def send_notification
    UserMailer.comment(self).deliver
  end
  
  STATUSES.each do |status|
    define_method("#{status}?") do
      self.status == status
    end
    
    # named_scope status.to_sym, :conditions => {:status => status}
  end
  
  # Convenience methods to simplify delimiter issues and make our
  # activity monitoring work smoothly
  def previous_commenters
    dream.comments.collect(&:dreamer).uniq.reject { |d| d == dreamer }
  end
  
  def dream_apparitions
    dream.apparitions
  end
  
  def dreamer_in_array
    [dream.dreamer]
  end
  
  def dreamer_followers
    dreamer.followers
  end
  
  def to_s
    dream.title
  end
  
  # include ActivityMonitor
  # monitor_activity :object_details => proc { |comment| [comment.dream.id, "comment on #{comment.dream.title}"] },
  #   :verb => 'made',
  #   :parties => {
  #     :dreamer_in_array => 'your dream',
  #     :previous_commenters => 'that you also commented on',
  #     :dream_apparitions => 'that you appeared in',
  #     :dreamer_followers => ''
  #   }
end
