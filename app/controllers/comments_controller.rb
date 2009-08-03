class CommentsController < ApplicationController
  before_filter :authenticate
  before_filter :load_dream
  
  def index
    @dreams = Dream.listings.paginate :per_page => 15, :page => params[:page], :order => ['comments_count DESC']
  end
  
  def create
    @comment = @dream.comments.build(params[:comment].merge(:dreamer_id => current_user.id))

    if @comment.save
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Sorry: we weren\'t able to save your comment. Please check and try again'
    end
    
    redirect_to @dream
  end
  
  protected
    def load_dream
      @dream = Dream.find(params[:dream_id])
    end
end
