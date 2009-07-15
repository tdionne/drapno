class Dreamer < ActiveRecord::Base
  include Clearance::User
  
  has_many :dreams
end
