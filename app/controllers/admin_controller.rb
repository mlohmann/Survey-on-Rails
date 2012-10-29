class AdminController < ApplicationController
    def index
        @questions = Question.all
        @tokens = Token.all 
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => {:questions=>@questions, :tokens=>@tokens, :outcomes=>@outcomes} }
        end
    end
end
