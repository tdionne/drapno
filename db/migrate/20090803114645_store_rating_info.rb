class StoreRatingInfo < ActiveRecord::Migration
  def self.up
    add_column :dreams, :average_rating, :decimal, :precision => 5, :scale => 3, :default => 0.0, :null => false
  end

  def self.down
    remove_column :dreams, :average_rating
  end
end
