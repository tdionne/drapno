class OptOutsController < ApplicationController
  before_filter :authenticate, :only => :destroy
  
  def show
    @appearance = Appearance.find_by_token_and_email!(params[:id], params[:email])
    @optout = OptOut.new(:email => params[:email], :token => params[:id])
  end
  
  def create
    if Appearance.exists?(params[:opt_out])
      @optout = OptOut.create!(params[:opt_out])
      flash[:notice] = "You will not receive more appearance notifications. If you change your mind you will need to sign up to Drapno and edit your account to enable future emails"
      redirect_to root_path and return
    else
      render_404 and return
    end
  end
  
  def destroy
    if current_user.opt_out and current_user.opt_out.destroy
      flash[:notice] = 'From now on you will receive dream appearance notifications'
    else
      flash[:error] = 'An error occurred'
    end
    
    redirect_to :back
  end
end
