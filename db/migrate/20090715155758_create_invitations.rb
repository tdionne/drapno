class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :first_name, :last_name, :email
      t.string :invitation_code, :limit => 40
      t.datetime :invited_at, :redeemed_at
      t.timestamps
    end
    
    add_index :invitations, [:id, :email]
    add_index :invitations, [:id, :invitation_code]
  end

  def self.down
    drop_table :invitations
  end
end
