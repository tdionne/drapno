# == Schema Information
#
# Table name: invitations
#
#  id              :integer(4)      not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  invitation_code :string(40)
#  invited_at      :datetime
#  redeemed_at     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

class Invitation < ActiveRecord::Base
  validates_presence_of :email, :on => :save, :message => "can't be blank"
  validates_uniqueness_of :email, :on => :save, :message => "is already registered"
  validates_format_of       :email, :with => %r{.+@.+\..+}
  
  named_scope :redeemable, :conditions => {:redeemed_at => nil}
  
  before_create :generate_code
  
  def invited?
    !!self.invitation_code && !!self.invited_at
  end

  def generate_code
    self.invitation_code = Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--#{self.email}--")
  end

  def redeem!
    self.redeemed_at = Time.now.utc
    self.save!
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
