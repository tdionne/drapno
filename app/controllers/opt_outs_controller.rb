class OptOutsController < ApplicationController
  def show
    @appearance = Appearance.find_by_token_and_email!(params[:id], params[:email])
    @optout = OptOut.new(:email => params[:email], :token => params[:id])
  end
  
  def create
    if Appearance.exists?(params[:opt_out])
      @optout = OptOut.create!(params[:opt_out])
      flash[:notice] = "You will not receive more appearance notifications"
      redirect_to root_path and return
    else
      render_404 and return
    end
  end
end
