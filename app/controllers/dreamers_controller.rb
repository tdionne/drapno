class DreamersController < Clearance::UsersController
  skip_before_filter :authenticate, :only => [:index, :new, :create]
  before_filter :validate_invitation, :if => :invitation_only?, :only => [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  def index
    if invitation_only?
      render :action => 'sent' and return
    end
  end
  
  def show
    if signed_in? and params[:id] == current_user.id.to_s and params[:public].nil?
      render :action => 'mydrapno'
    else
      @dreamer = Dreamer.find(params[:id], :include => {:dreams => :dreamer, :references => :dreamer})
    end
  end
  
  def edit
    @dreamer = current_user
  end
  
  def new
    @user = Dreamer.new
    if @invitation
      @user.name = @invitation.name
      @user.email = @invitation.email
      flash.now[:notice] = "We've pre-filled some values from the invitation you received."
    end
  end
  
  def update
    @dreamer = current_user
    respond_to do |format|
      if @dreamer.update_attributes(params[:dreamer])
        format.html { flash[:success] = 'Profile successfully updated'; redirect_to @dreamer }
        format.js { head :ok }
      else
        format.html { render :action => 'edit' }
        format.js { head :status => '400' }
      end
    end
  end
  
  def create
    @user = ::User.new params[:user]
    if @user.save
      @invitation.redeem! if @invitation
      flash_notice_after_create
      redirect_to(url_after_create)
    else
      render :action => 'new'
    end
  end
  
  private
  def flash_notice_after_create
    flash[:notice] = translate(:deliver_confirmation,
      :scope   => [:clearance, :controllers, :users],
      :default => "You will receive an email within the next few minutes. " <<
                  "It contains instructions for confirming your account. " <<
                  "If you don't see it within a few minutes don't forget to check your junk/spam mailbox.")
  end
end