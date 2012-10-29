class Outcome
  include MongoMapper::Document
  
  key :title, String
  key :description, String
  belongs_to :token
end
