class Token
  include MongoMapper::Document
  
  key :title, String
  one :outcome
end
