class CreateAppearances < ActiveRecord::Migration
  def self.up
    create_table :appearances do |t|
      t.string :role, :limit => 32
      t.integer :dream_id, :apparition_id
      t.string :name, :email, :limit => 64
      t.timestamps
    end
  end

  def self.down
    drop_table :appearances
  end
end
