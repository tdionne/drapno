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
#

class Dreamer < ActiveRecord::Base
  include Clearance::User
  AGE_BANDS = %W(18-25 26-35 36-45 45-65 65+)
  
  has_many :dreams
  has_many :appearances, :foreign_key => :apparition_id
  
  validates_presence_of :name
  validates_inclusion_of :gender, :in => %W(Male Female), :allow_nil => true, :message => 'is invalid'
  validates_inclusion_of :age_band, :in => AGE_BANDS, :allow_nil => true, :message => 'is invalid'
  
  attr_accessible :name, :location, :gender, :age_band
  
  def is_admin?
    true
  end
end
