class Invitation < ActiveRecord::Base
  validates_presence_of :email, :on => :save, :message => "can't be blank"
  validates_uniqueness_of :email, :on => :save, :message => "is already registered"

  named_scope :redeemable, :conditions => {:redeemed_at => nil}
  
  before_create :generate_code
  
  def invited?
    !!self.invitation_code && !!self.invited_at
  end

  def generate_code
    self.invitation_code = Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--#{self.email}--")
  end

  def redeemed!
    self.redeemed_at = Time.now.utc
    self.save!
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
