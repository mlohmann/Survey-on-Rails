class TokenImpact
  include MongoMapper::Document
  
  key :token_id, String
  key :token_title, String
  key :affirm_strength, Integer
  key :oppose_strength, Integer
  belongs_to :question
end
