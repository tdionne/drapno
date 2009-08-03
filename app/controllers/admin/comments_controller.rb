class Admin::CommentsController < Admin::BaseController
  # GET /admin_comments
  # GET /admin_comments.xml
  def index
    opts = { :per_page => 50, :page => params[:page], :include => [:dreamer, :dream] }    
    opts[:conditions] = {:status => params[:filter]} unless params[:filter].blank?
    
    @comments = Comment.paginate(opts)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /admin_comments/1
  # GET /admin_comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /admin_comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end


  # PUT /admin_comments/1
  # PUT /admin_comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(admin_comments_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_comments/1
  # DELETE /admin_comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }
    end
  end
end
