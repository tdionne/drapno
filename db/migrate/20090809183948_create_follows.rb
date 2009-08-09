class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table :follows do |t|
      t.integer :dreamer_id, :follower_id
      t.boolean :reciprocal # Not going to be used initially, but might as well have it
      t.timestamps
    end
    add_index :follows, :follower_id
    add_index :follows, :dreamer_id
  end

  def self.down
    remove_index :follows, :dreamer_id
    remove_index :follows, :follower_id
    drop_table :follows
  end
end
