class DreamCommentCount < ActiveRecord::Migration
  def self.up
    add_column :dreams, :comments_count, :integer, :null => false, :default => 0
    Dream.find_each { |dream| Dream.update_counters dream.id, :comments_count => dream.comments.count }
    
    add_column :dreamers, :comments_count, :integer, :null => false, :default => 0
    Dreamer.find_each { |dreamer| Dreamer.update_counters dreamer.id, :comments_count => dreamer.comments.count }
  end

  def self.down
    remove_column :dreams, :comments_count
    remove_column :dreamers, :comments_count
  end
end
