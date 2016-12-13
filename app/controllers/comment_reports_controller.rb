class CommentReportsController < ApplicationController
  before_filter :authenticate, {}
  before_filter :load_comment
  
  def new
    @report = @comment.reports.build
  end
  
  def create
    @report = @comment.reports.build(params[:comment_report].merge(:reporter_id => current_user.id))
    
    if @report.save
      flash[:notice] = 'Thank you. We have noted your concern.'
      redirect_to @comment.dream
    else
      render :action => 'new'
    end
  end
  
  protected
    def load_comment
      @comment = Comment.find(params[:comment_id], :include => :dream)
    end
end
