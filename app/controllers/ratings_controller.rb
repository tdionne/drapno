class RatingsController < ApplicationController
  before_filter :load_dreamer
  before_filter :authenticate, :only => :create
  
  # GET /ratings
  # GET /ratings.xml
  def index
    @ratings = @dreamer.ratings.all(:include => :dream)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    @rating = current_user.ratings.build(params[:rating])

    respond_to do |format|
      if @rating.save
        format.html { flash[:notice] = 'Rating was successfully created.'; redirect_to(@rating.dream) }
        format.js   { head :status => :created }
        format.xml  { render :xml => @rating, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.js   { render :status => '400 Bad Request' }        
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
    def load_dreamer
      @dreamer = Dreamer.find(params[:dreamer_id])
    end
end
