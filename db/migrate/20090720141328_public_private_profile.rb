class PublicPrivateProfile < ActiveRecord::Migration
  def self.up
    add_column :dreamers, :public_profile, :boolean, :default => true
  end

  def self.down
    remove_column :dreamers, :public_profile
  end
end
