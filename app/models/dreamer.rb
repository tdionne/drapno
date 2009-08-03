# == Schema Information
#
# Table name: dreamers
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean(1)      not null
#  last_signed_in_at  :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(128)
#  location           :string(255)
#  gender             :string(10)
#  age_band           :string(8)
#  ratings_count      :integer(4)      default(0), not null
#  public_profile     :boolean(1)      default(TRUE)
#  role               :string(255)     default("user"), not null
#  public_alias       :string(63)
#

class Dreamer < ActiveRecord::Base
  include Clearance::User
  AGE_BANDS = %W(18-25 26-35 36-45 45-65 65+)
  ROLES = %W(user admin)
  
  has_many :dreams
  has_many :appearances, :foreign_key => :apparition_id
  has_many :references, :through => :appearances, :class_name => 'Dream', :source => :dream
  has_many :ratings, :foreign_key => :rater_id
  has_many :comments
  has_many :comment_reports, :foreign_key => :reporter_id
  
  validates_presence_of :name
  validates_inclusion_of :gender, :in => %W(Male Female), :allow_nil => true, :message => 'is invalid'
  validates_inclusion_of :age_band, :in => AGE_BANDS, :allow_nil => true, :message => 'is invalid'
  
  attr_accessible :name, :location, :gender, :age_band, :public_profile
  
  xss_terminate
  
  ROLES.each do |role|
    define_method("is_#{role}?") do
      self.role == role
    end
    named_scope role.to_sym, :conditions => {:role => role}
  end
  
  def display_name
    self.public_alias.blank? ? self.name : self.public_alias
  end
  
  def to_s
    display_name
  end
  
  def has_rated?(dream)
    Rating.exists?(:dream_id => dream.id, :rater_id => self.id)
  end
end
