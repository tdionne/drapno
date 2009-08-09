class FollowsController < ApplicationController
  before_filter :authenticate
  
  def create
    follow = current_user.interests.build(:dreamer_id => params[:dreamer_id])
    respond_to do |wants|
      if follow.save
        wants.html { 
          flash[:notice] = "You are now following #{follow.dreamer}"; 
          redirect_to(:back) 
        }
        wants.js { head :created }
      else
        wants.html { 
          flash[:error] = "Couldn't create relationship"; 
          redirect_to(:back) 
        }
        wants.js { render :json => follow.errors.to_json }
      end
    end
  end
  
  def destroy
    follow = current_user.interests.find_by_dreamer_id(params[:dreamer_id])
    respond_to do |wants|
      if follow.destroy
        wants.html { 
          flash[:notice] = "Relationship removed"; 
          redirect_to(:back) 
        }
        wants.js { head :ok }
      else
        wants.html { flash[:error] = "Couldn't remove relationship" }
        wants.js { render 400 }
      end
    end
  end
end

