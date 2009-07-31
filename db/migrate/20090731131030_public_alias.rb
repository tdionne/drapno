class PublicAlias < ActiveRecord::Migration
  def self.up
    add_column :dreamers, :public_alias, :string, :limit => 63
  end

  def self.down
    remove_column :dreamers, :public_alias
  end
end
