class ClearanceCreateDreamers < ActiveRecord::Migration
  def self.up
    create_table(:dreamers) do |t|
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :name, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :token,              :limit => 128
      t.datetime :token_expires_at
      t.boolean  :email_confirmed, :default => false, :null => false
      t.datetime :last_signed_in_at
      t.timestamps
    end

    add_index :dreamers, [:id, :token]
    add_index :dreamers, :email
    add_index :dreamers, :token
  end

  def self.down
    drop_table :dreamers
  end
end
