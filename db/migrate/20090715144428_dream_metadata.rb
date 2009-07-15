class DreamMetadata < ActiveRecord::Migration
  def self.up
    add_column :dreams, :location, :string
    add_column :dreams, :dreamt_on, :date
  end

  def self.down
    remove_column :dreams, :dreamt_on
    remove_column :dreams, :location
  end
end
