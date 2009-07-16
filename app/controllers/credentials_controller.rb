class CredentialsController < ApplicationController
  def edit
    
  end
  
  def update
    if current_user.update_attributes(params[:dreamer])
      flash[:success] = 'Password updated'
      redirect_to current_user
    else
      render :action => 'edit'
    end
  end
end
