class AddFacebookIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :dreamers, :facebook_id, :string
    add_index :dreamers, :facebook_id
  end

  def self.down
    remove_index :dreamers, :facebook_id
    remove_column :dreamers, :facebook_id
  end
end