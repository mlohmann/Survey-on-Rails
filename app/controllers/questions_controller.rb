class QuestionsController < ApplicationController
  
  http_basic_authenticate_with :name => "foo", :password => "bar", :only => [:edit, :destroy, :create]
  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
     
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new 
     
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    tokens = Token.all
    for token in tokens
      @question.token_impacts.create(:token_id => token.id, :token_title => token.title, :affirm_strength => 0, :oppose_strength => 0)
    end
 
    respond_to do |format|
      if @question.save           
        format.html { redirect_to edit_question_path(@question), :notice => 'Question was successfully created.' }
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }         
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to edit_question_path(@question), :notice => 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to '/admin' }
      format.json { head :no_content }
    end
  end
end
