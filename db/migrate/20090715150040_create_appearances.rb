class CreateAppearances < ActiveRecord::Migration
  def self.up
    create_table :appearances do |t|
      t.string :role, :limit => 32
      t.integer :dream_id, :apparition_id
      t.string :name, :email, :limit => 64
      t.timestamps
    end
    
    add_index :appearances, :dream_id
    add_index :appearances, :apparition_id
  end

  def self.down
    remove_index :appearances, :dream_id
    drop_table :appearances
  end
end
