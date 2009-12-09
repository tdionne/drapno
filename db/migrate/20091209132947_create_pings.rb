class CreatePings < ActiveRecord::Migration
  def self.up
    create_table :pings do |t|
      t.string :from
      t.string :source

      t.timestamps
    end
    add_index :pings, :created_at
  end

  def self.down
    remove_index :pings, :created_at
    drop_table :pings
  end
end
