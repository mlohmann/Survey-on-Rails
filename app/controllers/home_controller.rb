class HomeController < ApplicationController
  def index
      @questions = Question.all
      
      respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @questions }
      end
  end
end
