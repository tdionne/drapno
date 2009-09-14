class Activity
  include MongoMapper::Document
  
  key :description, String
  key :for_user_id, Integer
  key :created_at, Time
end