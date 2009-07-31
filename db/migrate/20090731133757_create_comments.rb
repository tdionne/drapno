class CreateComments < ActiveRecord::Migration
  def self.up
    create_table "comments", :force => true do |t|
      t.integer  "dream_id"
      t.integer  "dreamer_id"
      t.string   "status",           :limit => 12, :default => "visible", :null => false
      t.text     "body"
      t.timestamps
    end
    
    add_index :comments, :dream_id
    add_index :comments, :dreamer_id
  end

  def self.down
    remove_index :comments, :dreamer_id
    remove_index :comments, :dream_id
    drop_table :comments
  end
end
