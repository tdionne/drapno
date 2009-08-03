class Admin::DreamersController < Admin::BaseController
  before_filter :load_dreamer, :only => [:edit, :update]
  
  def index
    @dreamers = Dreamer.paginate(:per_page => 40, :page => params[:page], :order => 'email')
  end
  
  def edit
  end
    
  def update
    @dreamer.role = params[:dreamer][:role] if params[:dreamer][:role]
    
    if @dreamer.update_attributes(params[:dreamer])
      flash[:notice] = 'Dreamer updated'
      redirect_to admin_dreamers_path
    else
      render :action => 'edit'
    end
  end

  protected
    def load_dreamer
      @dreamer = Dreamer.find(params[:id])
    end
end