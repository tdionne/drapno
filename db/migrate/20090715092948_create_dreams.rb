class CreateDreams < ActiveRecord::Migration
  def self.up
    create_table :dreams do |t|
      t.string :title
      t.text :story, :story_html
      t.integer :dreamer_id
      t.timestamps
    end
    
    add_index :dreams, :dreamer_id
    add_index :dreams, :created_at
  end

  def self.down
    remove_index :dreams, :created_at
    remove_index :dreams, :dreamer_id
    drop_table :dreams
  end
end
