class FollowsController < ApplicationController
  before_filter :authenticate, :if => proc { |c| ! c.request.format.atom? }
  before_filter :http_authenticate, :if => proc { |c| c.request.format.atom? }
  
  def index
    # following_ids = current_dreamer.interests.all(:select => 'dreamer_id', :limit => 20).collect { |f| f.dreamer_id }
    # my_dream_ids = current_dreamer.dreams.all(:select => 'id', :limit => 20).collect { |d| d.id }
    # dreams_ive_commented_on = current_dreamer.comments.all(:select => 'dream_id', :limit => 20).collect { |d| d.dream_id }
    # dreams_ive_appeared_in = current_dreamer.references.all(:limit => 20)
    # appearance_ids = dreams_ive_appeared_in.collect { |a| a.id }
    # 
    # recent_dreams = Dream.listings.all(:conditions => ['dreamer_id IN (?)', following_ids], :include => :dreamer)
    # recent_comments = Comment.available.all(:conditions => ['dreamer_id != ? AND (dream_id IN (?) OR dreamer_id IN (?))', 
    #   current_dreamer.id, (my_dream_ids + dreams_ive_commented_on + appearance_ids).uniq, following_ids])
    # 
    # @updates = (dreams_ive_appeared_in + recent_dreams + recent_comments).sort { |a, b| b.created_at <=> a.created_at }
    @updates = Activity.paginate :per_page => 50, :page => params[:page], :conditions => ['for_user_id = ?', current_user.id], :order => 'created_at DESC'
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

