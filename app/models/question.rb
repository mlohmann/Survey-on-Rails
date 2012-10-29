class Question
  include MongoMapper::Document

  key  :text, String 
  many :token_impacts
end
