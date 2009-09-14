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
  
  def previous_commenters
    dream.comments.collect(&:dreamer).uniq.reject { |d| d == dreamer }
  end
  
  after_create :store_activity
  def store_activity
    params = {:object_type => 'Comment', :verb => 'made', :object_id => self.id, :actor_id => dreamer.id, 
      :object_name => "comment on #{dream.title}", :actor_name => dreamer.name}

    Activity.create(params.merge(:for_user_id => dream.dreamer.id, :reason => 'your dream'))
    notified = [dream.dreamer.id]
    
    dream.apparitions.each do |apparition|
      unless notified.include?(apparition.id)
        Activity.create(params.merge(:for_user_id => apparition.id, :reason => 'that you appeared in'))
        notified << apparition.id
      end
    end
    
    previous_commenters.each do |commenter|
      unless notified.include?(commenter.id)
        Activity.create(params.merge(:for_user_id => commenter.id, :reason => 'that you also commented on'))
        notified << commenter.id
      end
    end
    
    dreamer.followers.each do |follower|
      unless notified.include?(follower.id)
        Activity.create(params.merge(:for_user_id => follower.id))
        notified << follower.id
      end
    end
  end
  
end
