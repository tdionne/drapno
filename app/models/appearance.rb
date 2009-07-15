class Appearance < ActiveRecord::Base
  belongs_to :dream
  belongs_to :apparition, :class_name => 'Dreamer'
  
  # validates_presence_of :dream
  validates_presence_of :name
  validates_presence_of :email
  
  before_create :identify_apparition
  
  protected
    def identify_apparition
      apparition = Dreamer.find_by_email(self.email)
      self.apparition_id = apparition.id if apparition
    end
  
end
