class ClearanceUpdateDreamers < ActiveRecord::Migration
  def self.up
    change_table(:dreamers) do |t|
      t.column :confirmation_token, :string, :limit => 128
      t.column :remember_token, :string, :limit => 128
    end

    add_index :dreamers, [:id, :confirmation_token]
    add_index :dreamers, :remember_token
  end

  def self.down
  end
end
