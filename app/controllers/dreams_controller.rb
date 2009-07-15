class DreamsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  
  # GET /dreams
  # GET /dreams.xml
  def index
    @dreams = Dream.all(:include => :dreamer)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dreams }
    end
  end

  # GET /dreams/1
  # GET /dreams/1.xml
  def show
    @dream = Dream.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dream }
    end
  end

  # GET /dreams/new
  # GET /dreams/new.xml
  def new
    @dream = Dream.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dream }
    end
  end

  # GET /dreams/1/edit
  def edit
    @dream = current_user.dreams.find(params[:id])
  end

  # POST /dreams
  # POST /dreams.xml
  def create
    @dream = current_user.dreams.build(params[:dream])

    respond_to do |format|
      if @dream.save
        flash[:notice] = 'Dream was successfully created.'
        format.html { redirect_to(@dream) }
        format.xml  { render :xml => @dream, :status => :created, :location => @dream }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dream.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dreams/1
  # PUT /dreams/1.xml
  def update
    @dream = current_user.dreams.find(params[:id])

    respond_to do |format|
      if @dream.update_attributes(params[:dream])
        flash[:notice] = 'Dream was successfully updated.'
        format.html { redirect_to(@dream) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dream.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dreams/1
  # DELETE /dreams/1.xml
  def destroy
    @dream = current_user.dreams.find(params[:id])
    @dream.destroy

    respond_to do |format|
      format.html { redirect_to(dreams_url) }
      format.xml  { head :ok }
    end
  end
end