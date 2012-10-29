class TokenImpactsController < ApplicationController
  
  http_basic_authenticate_with :name => "foo", :password => "bar", :only => [:edit, :destroy, :create]
  
  # GET /token_impacts
  # GET /token_impacts.json
  def index
    @token_impacts = TokenImpact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @token_impacts }
    end
  end

  # GET /token_impacts/1
  # GET /token_impacts/1.json
  def show
    @token_impact = TokenImpact.find(params[:id])
    @token = Token.find @token_impact.token_id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @token_impact }
    end
  end

  # GET /token_impacts/new
  # GET /token_impacts/new.json
  def new
    @token_impact = TokenImpact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @token_impact }
    end
  end

  # GET /token_impacts/1/edit
  def edit
    @token_impact = TokenImpact.find(params[:id])
    @token = Token.find @token_impact.token_id
  end

  # POST /token_impacts
  # POST /token_impacts.json
  def create
    @token_impact = TokenImpact.new(params[:token_impact])

    respond_to do |format|
      if @token_impact.save
        format.html { redirect_to @token_impact, :notice => 'Token impact was successfully created.' }
        format.json { render :json => @token_impact, :status => :created, :location => @token_impact }
      else
        format.html { render :action => "new" }
        format.json { render :json => @token_impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /token_impacts/1
  # PUT /token_impacts/1.json
  def update
    @token_impact = TokenImpact.find(params[:id])

    respond_to do |format|
      if @token_impact.update_attributes(params[:token_impact])
        format.html { redirect_to edit_question_path(@token_impact.question), :notice => 'Token impact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @token_impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /token_impacts/1
  # DELETE /token_impacts/1.json
  def destroy
    @token_impact = TokenImpact.find(params[:id])
    @token_impact.destroy

    respond_to do |format|
      format.html { redirect_to '/admin' }
      format.json { head :no_content }
    end
  end
end
