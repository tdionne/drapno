class CreateDreams < ActiveRecord::Migration
  def self.up
    create_table :dreams do |t|
      t.string :title
      t.text :story, :story_html
      t.integer :dreamer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :dreams
  end
end
