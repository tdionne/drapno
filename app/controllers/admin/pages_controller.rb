class Admin::PagesController < Admin::BaseController
  def index
    @pages = Page.all
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { flash[:notice] = 'Page updated'; redirect_to admin_pages_url }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
end
