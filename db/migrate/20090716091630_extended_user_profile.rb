class ExtendedUserProfile < ActiveRecord::Migration
  def self.up
    add_column :dreamers, :location, :string
    add_column :dreamers, :gender, :string, :limit => 10
    add_column :dreamers, :age_band, :string, :limit => 8
  end

  def self.down
    remove_column :dreamers, :age_band
    remove_column :dreamers, :gender
    remove_column :dreamers, :location
  end
end
