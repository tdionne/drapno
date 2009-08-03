class Admin::PagesController < Admin::BaseController
  before_filter :load_page, :only => [:edit, :update]
  
  def index
    @pages = Page.all
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { flash[:notice] = 'Page updated'; redirect_to admin_pages_url }
      else
        format.html { render :action => 'edit' }
      end
    end
  end
  
  protected
    def load_page
      @page = Page.find(params[:id])
    end
end
