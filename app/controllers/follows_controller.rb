class FollowsController < ApplicationController
  before_filter :authenticate, :if => proc { |c| ! c.request.format.atom? }
  before_filter :http_authenticate, :if => proc { |c| c.request.format.atom? }
  
  def index
    @updates = Activity.paginate :per_page => 20, :page => params[:page], 
      :conditions => {:for_user_id => current_user.id}, :order => 'created_at DESC'
  end
  
  def create
    follow = current_dreamer.interests.build(:dreamer_id => params[:dreamer_id])
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
    follow = current_dreamer.interests.find_by_dreamer_id(params[:dreamer_id])
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

