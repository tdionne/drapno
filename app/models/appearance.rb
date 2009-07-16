# == Schema Information
#
# Table name: appearances
#
#  id            :integer(4)      not null, primary key
#  role          :string(32)
#  dream_id      :integer(4)
#  apparition_id :integer(4)
#  name          :string(64)
#  email         :string(64)
#  created_at    :datetime
#  updated_at    :datetime
#

class Appearance < ActiveRecord::Base
  belongs_to :dream
  belongs_to :apparition, :class_name => 'Dreamer'
  
  # validates_presence_of :dream
  validates_presence_of :name
  validates_presence_of :email
  
  before_create :identify_apparition
  after_create :send_notification
  
  xss_terminate
  
  protected
    def send_notification
      UserMailer.deliver_appearance self
    end
    
    def identify_apparition
      apparition = Dreamer.find_by_email(self.email)
      self.apparition_id = apparition.id if apparition
    end
  
end
