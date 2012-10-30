# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


token = Token.create(:title => 'my passionate issue')
token.outcome = Outcome.new(:title => 'my passionate issue', :description => 'this is a possible consqeunce' )

question = Question.create(:text => 'Should the government be doing more?')
tokens = Token.all
for token in tokens
    question.token_impacts.create(:token_id => token.id, :token_title => token.title, :affirm_strength => 0, :oppose_strength => 0)
end