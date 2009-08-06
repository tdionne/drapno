class ApparitionRelationship < ActiveRecord::Migration
  def self.up
    add_column :appearances, :relationship, :string
    add_column :appearances, :is_public_figure, :boolean
  end

  def self.down
    remove_column :appearances, :is_public_figure
    remove_column :appearances, :relationship
  end
end
