class Activity
  include MongoMapper::Document
  
  key :object_type, String
  key :object_name, String
  key :object_id, Integer
  
  key :verb, String
  key :reason, String
  key :url, String

  key :from_user_id, Integer  
  key :for_user_id, Integer

  key :created_at, Time
  key :updated_at, Time
  
  before_save :set_timestamps
  
  def set_timestamps
    self.updated_at = Time.now
    self.created_at = self.updated_at unless self.created_at
  end
  
end