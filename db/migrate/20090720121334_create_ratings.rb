class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :score, :rater_id, :dream_id
      t.timestamps
    end
    add_index :ratings, :dream_id
    
    add_column :dreamers, :ratings_count, :integer, :null => false, :default => 0
    add_column :dreams, :ratings_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_index :ratings, :dream_id
    remove_column :dreamers, :ratings_count
    drop_table :ratings
  end
end
