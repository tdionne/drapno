class AppearanceHash < ActiveRecord::Migration
  def self.up
    add_column :appearances, :token, :string
  end

  def self.down
    remove_column :appearances, :token
  end
end
