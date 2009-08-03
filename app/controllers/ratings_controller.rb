class RatingsController < ApplicationController
  before_filter :load_dreamer, :only => :create
  before_filter :authenticate, :only => :create
  
  # GET /ratings
  # GET /ratings.xml
  def index
    @dreams = Dream.listings.paginate :per_page => 15, :page => params[:page], :order => ['average_rating DESC']
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    # work around the jquery rating plugin we're using
    if params[:id] and params[:rating].is_a?(String)
      params[:rating] = { :score => params[:rating], :dream_id => params[:id] }
    end
    
    # Slightly ugly, but for now we're letting users overwrite their previous
    # ratings.
    @rating = current_user.ratings.find_or_initialize_by_dream_id(params[:rating])
    @rating.attributes = params[:rating] unless @rating.new_record?

    respond_to do |format|
      if @rating.save
        format.html { flash[:notice] = 'Rating was successfully created.'; redirect_to(@rating.dream) }
        format.js   { render :text => @rating.dream.ratings.average(:score), :status => :created }
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
