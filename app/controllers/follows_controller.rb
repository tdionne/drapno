class FollowsController < ApplicationController
  before_filter :authenticate
  
  def index
    following_ids = current_user.interests.all(:select => 'dreamer_id', :limit => 20).collect { |f| f.dreamer_id }
    my_dream_ids = current_user.dreams.all(:select => 'id', :limit => 20).collect { |d| d.id }

    recent_dreams = Dream.listings.all(:conditions => ['dreamer_id IN (?)', following_ids])
    recent_comments = Comment.available.all(:conditions => ['dream_id IN (?)', my_dream_ids])
    
    @updates = (recent_dreams + recent_comments).sort { |a, b| b.created_at <=> a.created_at }
    # 
    # SELECT * FROM dreams WHERE dreamer_id IN (dreamer_list);
    # SELECT * FROM comments WHERE commenter_id IN (dreamer_list);
    
  end
  
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

