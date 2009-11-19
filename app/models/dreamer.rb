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
#  comments_count     :integer(4)      default(0), not null
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

  # The follow stuff is a little awkward linguistically.
  # A "follow" is a request from a follower to follow this dreamer
  # A "follower" is the dreamer who made that request
  # An "interest" is the request to follow another dreamer
  # A "followee" is a person I am following
  has_many :follows
  has_many :followers, :through => :follows
  has_many :interests, :class_name => 'Follow', :foreign_key => 'follower_id'
  has_many :followees, :through => :interests, :source => :dreamer
  
  Paperclip.interpolates(:random_default_url) do |attachment, style| 
    style = 'medium' if style == :original
    options = Dir.glob(RAILS_ROOT + "/public/images/avatars/*_#{style}.*")
    if options.any?
      options[rand(options.size - 1)].sub(RAILS_ROOT + "/public", "")
    end
  end
  
  has_attached_file :picture, :styles => { :regular => '180x180#', :thumb => "27x27#" }, :default_url => ":random_default_url"

  validates_attachment_content_type :picture, :content_type => /^image\/.*/
  
  validates_presence_of :name
  validates_inclusion_of :gender, :in => %W(Male Female), :allow_nil => true, :message => 'is invalid'
  validates_inclusion_of :age_band, :in => AGE_BANDS, :allow_nil => true, :message => 'is invalid'
  validates_inclusion_of :role, :in => ROLES, :allow_nil => true, :message => 'is invalid'  
  
  attr_accessible :name, :location, :gender, :age_band, :public_profile, :public_alias, :picture
  
  has_one :opt_out, :foreign_key => 'email', :primary_key => 'email'
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
  
  def is_following?(dreamer)
    interests.exists?(:dreamer_id => dreamer.id)
  end
  
  def has_rated?(dream)
    self.ratings.exists?(:dream_id => dream.id)
  end
  
  def can_rate?(dream)
    dream.dreamer != self
  end
  
  def calendar_data_for(start_date)
    end_date = start_date + 1.month

    {
      :appearances => references.all(:conditions => {:dreamt_on => (start_date..end_date)}),
      :dreams => dreams.all(:conditions => {:dreamt_on => (start_date..end_date)})
    }
  end
end
