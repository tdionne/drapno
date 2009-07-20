class UserRoles < ActiveRecord::Migration
  def self.up
    add_column :dreamers, :role, :string, :default => 'user', :null => false
  end

  def self.down
    remove_column :dreamers, :role
  end
end
